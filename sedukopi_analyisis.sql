-- -----------------------------------------------------------------------------
-- BUSINESS CASE #1: Outlet Revenue Ranking
-- Objective : Menghitung total revenue per gerai dan mengurutkannya dari yang 
--             tertinggi hingga terendah dengan memfilter gerai non-aktif.
-- -------------------------------------------------------------------------------
select
	o.outlet_id,
	o.name , 
	o.city, 
	sum(o2.total_amount) as revenue,
	RANK() OVER (
        ORDER BY SUM(o2.total_amount) DESC
    ) AS revenue_rank
from sedukopi.outlets o
inner join sedukopi.orders o2 on o2.outlet_id = o.outlet_id
where o.status = 'active'
group by o.name , o.city, o.outlet_id 
order by sum(o2.total_amount) desc


-- -----------------------------------------------------------------------------
-- BUSINESS CASE #2: Top Performing Items & Category Volume Contribution
-- Objective : Identifikasi Top 5 produk terlaris di setiap kategori menu 
--             beserta persentase kontribusi volume penjualan per kategori.
-- -----------------------------------------------------------------------------
-- 2A. Top 5 Menu Terlaris per Kategori (Berdasarkan Kuantitas Terjual)

with top_categories as (
	select 
		mi.category, 
		mi."name" ,
		sum(od.quantity) as total_quantity,
		DENSE_RANK() OVER (PARTITION BY mi.category ORDER BY SUM(od.quantity) DESC) AS quantity_rank
	from sedukopi.menu_items mi
	inner join sedukopi.order_details od on od.item_id = mi.item_id
	group by mi.category, mi."name"  
)

select * from top_categories tc
where tc.quantity_rank <= 5
ORDER BY category, quantity_rank ASC, total_quantity DESC;


-- 2B. Persentase Kontribusi Volume Penjualan per Kategori Menu
	SELECT 
	    mi.category,
	    SUM(od.quantity) AS total_unit_terjual,
	    ROUND(
	        (SUM(od.quantity) * 100.0 / SUM(SUM(od.quantity)) OVER ()), 2
	    ) AS persentase_kontribusi
	FROM sedukopi.menu_items mi
	INNER JOIN sedukopi.order_details od ON od.item_id = mi.item_id
	GROUP BY mi.category
	ORDER BY total_unit_terjual DESC;


-- -----------------------------------------------------------------------------
-- BUSINESS CASE #3: Daily Peak Hours Profiling
-- Objective : Menganalisis pola transaksi harian berdasarkan komponen jam 
--             guna pengoptimalan penjadwalan shift kerja staf.
-- Note      : Termasuk casting tipe data order_time ke TIME.
-- -----------------------------------------------------------------------------
-- 3A. Agregat Jam Ramai Harian (Nasional)
select
	extract(HOUR FROM o.order_time::time) as transaction_hour,
	count(o.order_id) as total_transaction
from  sedukopi.orders o
inner join sedukopi.outlets ou on ou.outlet_id = o.outlet_id
where ou.status = 'active'
group by extract(HOUR FROM o.order_time::time)
ORDER BY  transaction_hour ASC;


-- 3B. Distribusi Jam Ramai Harian per Kota
select
	ou.city,
	extract(HOUR FROM o.order_time::time) as transaction_hour,
	count(o.order_id) as total_transaction
from  sedukopi.orders o
inner join sedukopi.outlets ou on ou.outlet_id = o.outlet_id
where ou.status = 'active'
group by extract(HOUR FROM o.order_time::time), ou.city
ORDER BY  ou.city, transaction_hour ASC;



-- -----------------------------------------------------------------------------
-- BUSINESS CASE #6: Order Channel Performance Analysis (AOV & Peak Hours)
-- Objective : Membandingkan Average Order Value (AOV), porsi volume order, 
--             serta pola jam sibuk spesifik untuk setiap tipe pemesanan.
-- -----------------------------------------------------------------------------
-- 6A. Ringkasan Performa Channel (AOV & Persentase Total Transaksi)

select 
	o.order_type, 
	count(o.order_id ) as total_orders,
	round(AVG(o.total_amount ),2) as aov,
	ROUND(COUNT(o.order_id) * 100.0 / SUM(COUNT(o.order_id)) OVER(), 2) AS order_percent
from sedukopi.orders o
group by o.order_type
order by aov desc

-- 6B. Distribusi Volume Tipe Pemesanan Berdasarkan Jam Harian
SELECT 
	EXTRACT(HOUR FROM o.order_time::time) AS transaction_hour,
    o.order_type,
    COUNT(o.order_id) AS total_orders
FROM sedukopi.orders o
INNER JOIN sedukopi.outlets ou ON ou.outlet_id = o.outlet_id
WHERE ou.status = 'active'
GROUP BY EXTRACT(HOUR FROM o.order_time::time), o.order_type
ORDER BY transaction_hour ASC, o.order_type;



-- -----------------------------------------------------------------------------
-- BUSINESS CASE #7: Menu Pareto Analysis
-- Objective : Menghitung persentase kontribusi individu dan persentase revenue 
--             kumulatif per menu untuk mengklasifikasikan portofolio produk.
-- ----------------------------------------------------------------------------- 
WITH menu_revenue AS (
    SELECT
        mi.item_id,
        mi.name AS menu_name,
        mi.category,
        SUM(od.subtotal) AS total_revenue
    FROM sedukopi.menu_items mi
    INNER JOIN sedukopi.order_details od
        ON od.item_id = mi.item_id
    GROUP BY
        mi.item_id,
        mi.name,
        mi.category
),

ranked_revenue AS (
    SELECT
        item_id,
        menu_name,
        category,
        total_revenue,
        -- Contribution tiap menu terhadap total revenue
        ROUND(total_revenue * 100.0 / SUM(total_revenue) OVER(), 2) AS revenue_percentage,
        -- Revenue kumulatif
        SUM(total_revenue) OVER(
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ) AS cumulative_revenue,
        -- Total seluruh revenue
        SUM(total_revenue) OVER() AS grand_total_revenue
    FROM menu_revenue
)

SELECT
    item_id,
    menu_name,
    total_revenue,
    category,
    revenue_percentage,
    -- Persentase revenue kumulatif
    ROUND(cumulative_revenue * 100.0 / grand_total_revenue, 2) AS cumulative_percentage
FROM ranked_revenue
ORDER BY total_revenue DESC;