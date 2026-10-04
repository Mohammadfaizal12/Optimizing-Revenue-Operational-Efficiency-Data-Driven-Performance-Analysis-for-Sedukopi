# Optimizing Revenue & Operational Efficiency: Data-Driven Performance Analysis for Sedukopi

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Business Questions](#2-business-questions)

   * [2.1 Outlet Revenue Performance](#21-outlet-revenue-performance)
   * [2.2 Product Performance](#22-product-performance)
   * [2.3 Transaction Performance](#23-transaction-performance)
   * [2.4 Menu Revenue Contribution](#24-menu-revenue-contribution)
3. [Dataset & Data Preparation](#3-dataset--data-preparation)
4. [Analysis](#4-analysis)

   * [4.1 Outlet Revenue Performance](#41-outlet-revenue-performance)
   * [4.2 Best-Selling Menu by Category](#42-best-selling-menu-by-category)
   * [4.3 Peak Hour Analysis](#43-peak-hour-analysis)
   * [4.4 Order Type & Channel Analysis](#44-order-type--channel-analysis)
   * [4.5 Menu Revenue Contribution — Pareto Analysis](#45-menu-revenue-contribution--pareto-analysis)
5. [Key Insights](#5-key-insights)

   * [5.1 Outlet Performance](#51-outlet-performance)
   * [5.2 Product Performance](#52-product-performance)
   * [5.3 Peak Hour Performance](#53-peak-hour-performance)
   * [5.4 Order Channel Performance](#54-order-channel-performance)
   * [5.5 Menu Revenue Distribution](#55-menu-revenue-distribution)
6. [Business Recommendations](#6-business-recommendations)

   * [6.1 Investigate Low-Performing Outlets](#61-investigate-low-performing-outlets)
   * [6.2 Prioritize High-Volume Products](#62-prioritize-high-volume-products)
   * [6.3 Optimize Workforce Scheduling](#63-optimize-workforce-scheduling)
   * [6.4 Optimize Channel Operations](#64-optimize-channel-operations)
   * [6.5 Evaluate Long-Tail Menu](#65-evaluate-long-tail-menu)
7. [Tools & Skills](#7-tools--skills)

   * [PostgreSQL](#postgresql)
   * [Microsoft Excel](#microsoft-excel)
   * [Analytical Workflow](#analytical-workflow)

---

## 1. Project Overview

**Sedukopi Operations & Sales Performance Analysis** merupakan proyek analisis data end-to-end yang bertujuan untuk menganalisis performa penjualan dan operasional pada **20 outlet coffee shop** di beberapa kota.

Proyek ini menggunakan **PostgreSQL** untuk proses data querying, aggregation, dan analysis, sedangkan **Microsoft Excel** digunakan untuk exploratory analysis, visualisasi, dan business reporting.

Analisis difokuskan pada lima area utama:

* 🏪 Performa revenue setiap outlet
* ☕ Produk dengan volume penjualan tertinggi berdasarkan kategori
* ⏰ Pola transaksi berdasarkan waktu dan peak hours
* 🛍️ Performa berdasarkan tipe order dan channel
* 📊 Kontribusi revenue setiap menu menggunakan Pareto Analysis

Tujuan proyek ini adalah mengubah data transaksi menjadi **insight yang dapat ditindaklanjuti** untuk mendukung perencanaan operasional, inventory management, product strategy, dan channel optimization.

### Executive Summary

| Business Area           | Key Finding                                                                                                                                           |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Outlet Performance**  | **Sedukopi - Senopati (OUT003)** menghasilkan revenue tertinggi sebesar **Rp25,53 juta** dari 18 outlet aktif.                                        |
| **Product Performance** | **Coffee** menjadi kategori dengan volume penjualan terbesar, yaitu **36,18% (3.695 unit)**.                                                          |
| **Peak Hours**          | Transaksi menunjukkan **tiga pola peak period**: pagi, siang, dan sore/malam.                                                                         |
| **Order Channels**      | **Dine-In** memiliki volume transaksi terbesar sebesar **51,10% (2.555 orders)**, sedangkan **Delivery** memiliki AOV tertinggi sebesar **Rp81.306**. |
| **Menu Contribution**   | **48 dari 70 menu (68,57%)** menghasilkan sekitar **80,35% total revenue menu**.                                                                      |

---

## 2. Business Questions

Proyek ini dirancang untuk menjawab beberapa pertanyaan bisnis berikut.

### 2.1 Outlet Revenue Performance

* Outlet mana yang menghasilkan revenue tertinggi?
* Outlet mana yang menghasilkan revenue terendah?
* Bagaimana perbedaan performa revenue antar outlet aktif?

### 2.2 Product Performance

* Kategori produk mana yang memiliki volume penjualan tertinggi?
* Produk apa yang menjadi best seller pada masing-masing kategori?
* Produk mana yang perlu mendapatkan prioritas dalam inventory dan persiapan operasional?

### 2.3 Transaction Performance

* Kapan periode transaksi Sedukopi paling ramai?
* Bagaimana pola transaksi berdasarkan jam?
* Bagaimana perbedaan volume transaksi dan **Average Order Value (AOV)** berdasarkan tipe order?
* Kapan masing-masing channel memiliki volume transaksi tertinggi?

### 2.4 Menu Revenue Contribution

* Apakah revenue Sedukopi terkonsentrasi pada sebagian kecil menu?
* Berapa banyak menu yang berkontribusi terhadap sekitar 80% total revenue?
* Bagaimana distribusi revenue berdasarkan keseluruhan menu?

---

## 3. Dataset & Data Preparation

Data diproses menggunakan **PostgreSQL** sebelum digunakan untuk analisis dan visualisasi menggunakan Microsoft Excel.

### Data Preparation

Tahapan data preparation yang dilakukan meliputi:

* Menggabungkan data outlet dan transaksi menggunakan `JOIN`.
* Melakukan filtering terhadap outlet berdasarkan status operasional.
* Mengelompokkan data berdasarkan outlet, kategori produk, waktu transaksi, dan tipe order.
* Melakukan aggregation menggunakan `SUM()`, `AVG()`, dan `COUNT()`.
* Menggunakan `CASE WHEN` untuk kebutuhan conditional calculation.
* Menggunakan `EXTRACT()` untuk mengambil informasi jam dari waktu transaksi.
* Menggunakan **Window Functions** untuk menghitung persentase kontribusi.
* Menggunakan **CTE** untuk menyusun query analisis secara terstruktur.

### Penanganan Outlet Tidak Aktif

Dataset terdiri dari **20 outlet**.

Namun, terdapat dua outlet yang berstatus `temporarily_closed` dan tidak memiliki transaksi:

* OUT015
* OUT018

Kedua outlet tersebut dikeluarkan dari perbandingan performa sehingga analisis revenue outlet berfokus pada **18 outlet aktif**.

### Data Aggregation

Beberapa metrik yang digunakan dalam analisis meliputi:

* Total revenue
* Total orders
* Total quantity
* Order share
* Average Order Value (AOV)
* Revenue contribution
* Cumulative revenue contribution

---

## 4. Analysis

Analisis dilakukan menggunakan **PostgreSQL** untuk querying dan aggregation, kemudian hasilnya digunakan dalam **Microsoft Excel** untuk exploratory analysis dan visualisasi.

Analisis mencakup lima area utama:

1. Outlet Revenue Performance
2. Best-Selling Menu by Category
3. Peak Hour Analysis
4. Order Type & Channel Analysis
5. Menu Revenue Contribution — Pareto Analysis

---

### 4.1 Outlet Revenue Performance

#### Business Question

> Outlet Sedukopi mana yang menghasilkan revenue tertinggi dan mana yang memiliki performa revenue terendah?

#### Analytical Approach

* Menggabungkan data outlet dan transaksi.
* Mengagregasikan `total_amount` berdasarkan outlet.
* Memfilter outlet yang berstatus `temporarily_closed`.
* Melakukan ranking outlet aktif berdasarkan total revenue.

#### Key Finding

**Sedukopi - Senopati (OUT003)** menempati peringkat pertama dengan revenue sebesar:

**Rp25,53 juta**

Sementara itu, **Sedukopi - Margonda (OUT020)** menjadi outlet dengan revenue terendah di antara 18 outlet aktif dengan:

**Rp15,99 juta**

OUT015 dan OUT018 tidak memiliki transaksi karena berstatus `temporarily_closed`, sehingga tidak dimasukkan dalam ranking outlet aktif.

#### Business Implication

Perbedaan performa antar outlet dapat menjadi dasar untuk mengevaluasi faktor seperti:

* Customer demand
* Performa lokasi
* Product mix
* Local marketing
* Operational execution

<p align="center">
<img width="543" height="315" alt="Outlet chart" src="https://github.com/user-attachments/assets/f1787fd1-2dff-484b-bea6-3e72be99373e" />
</p>

---

### 4.2 Best-Selling Menu by Category

#### Business Question

> Produk apa yang memiliki volume penjualan tertinggi pada masing-masing kategori?

#### Analytical Approach

* Mengagregasikan `quantity` dari order details.
* Mengelompokkan produk berdasarkan kategori.
* Melakukan ranking produk dalam setiap kategori.
* Membandingkan kontribusi volume penjualan antar kategori.

#### Key Finding

Kategori **Coffee** memiliki volume penjualan terbesar dengan:

**3.695 unit — 36,18% dari total unit terjual**

| Category   | Best-Selling Product   | Units Sold |
| ---------- | ---------------------- | ---------: |
| Coffee     | Matcha Espresso Fusion |        180 |
| Makanan    | Croissant Butter       |        176 |
| Non-Coffee | Strawberry Smoothie    |        174 |
| Snack      | Cheese Cake Slice      |        177 |

Total volume penjualan tercatat sebesar **10.214 unit**.

#### Business Implication

Produk dengan volume penjualan tinggi dapat menjadi prioritas dalam:

* Inventory availability
* Product promotion
* Stock planning
* Operational preparation

---

### 4.3 Peak Hour Analysis

#### Business Question

> Kapan periode transaksi Sedukopi paling ramai?

#### Analytical Approach

* Mengambil informasi jam dari waktu transaksi.
* Mengelompokkan transaksi berdasarkan jam.
* Menganalisis pola transaksi di seluruh outlet.
* Mengidentifikasi periode peak dan off-peak.

#### Key Finding

Transaksi Sedukopi menunjukkan **tiga pola peak period**:

| Periode | Waktu       | Pola         |
| ------- | ----------- | ------------ |
| Morning | 07:00–08:00 | Morning Peak |
| Lunch   | 12:00–13:00 | Highest Peak |
| Evening | 17:00–19:00 | Evening Peak |

Periode dengan aktivitas relatif lebih rendah berada pada:

* 09:00–11:00
* 14:00–16:00

<p align="center">
<img width="543" height="315" alt="Peak hours chart" src="https://github.com/user-attachments/assets/72ebc40c-8e11-470a-b5a8-b1fc543e56ea" />
</p>

#### Business Implication

Pola peak hours dapat digunakan sebagai dasar untuk mengoptimalkan workforce scheduling.

Contohnya:

* Menambah staffing selama peak hours.
* Melakukan restocking pada periode off-peak.
* Mengalokasikan persiapan produk berdasarkan estimasi volume transaksi.

---

### 4.4 Order Type & Channel Analysis

#### Business Question

> Bagaimana perbedaan pola transaksi, Average Order Value (AOV), dan peak transaction hours pada `dine_in`, `takeaway`, dan `delivery`?

#### Analytical Approach

* Menghitung Average Order Value (AOV) setiap channel menggunakan `AVG(total_amount)`.
* Menghitung volume share (`order_percent`) menggunakan Window Functions.
* Menganalisis distribusi transaksi berdasarkan jam pada setiap channel.

#### Key Finding

Setiap channel menunjukkan karakteristik volume transaksi dan AOV yang berbeda.

| Order Type   | Total Orders | Order Share (%) | Average Order Value (AOV) | Peak Period                           | Highest Hourly Volume |
| ------------ | -----------: | --------------: | ------------------------: | ------------------------------------- | --------------------: |
| **Dine-In**  |        2.555 |      **51,10%** |              **Rp77.631** | 12:00–13:00 & 17:00–19:00             |   **315 orders/hour** |
| **Takeaway** |        1.479 |      **29,58%** |              **Rp78.443** | 07:00–08:00, 12:00–13:00, 17:00–19:00 |   **181 orders/hour** |
| **Delivery** |          966 |      **19,32%** |              **Rp81.306** | 07:00, 12:00, 18:00                   |   **120 orders/hour** |

Beberapa temuan utama:

* **Volume Share:** Dine-In mendominasi volume transaksi dengan **51,10% atau 2.555 orders**.
* **AOV:** Delivery memiliki AOV tertinggi sebesar **Rp81.306**, meskipun memiliki volume terendah sebesar 19,32%.
* **AOV Dine-In:** Dine-In memiliki AOV terendah sebesar **Rp77.631**.
* **Peak Volume:** Dine-In mencapai volume tertinggi pada pukul **13:00 dengan 315 orders**, sedangkan Takeaway mencapai volume tertinggi pada pukul **07:00 dengan 181 orders**.

#### Business Implication

**Delivery Upselling & Bundling**

AOV Delivery yang lebih tinggi menunjukkan peluang untuk memanfaatkan bundling dan upselling untuk meningkatkan nilai transaksi.

**Dine-In Basket Size Optimization**

Dine-In memiliki lebih dari setengah total orders tetapi memiliki AOV terendah. Hal ini membuka peluang untuk meningkatkan basket size melalui add-on, pastry, atau size upgrade.

**Operational Allocation**

Packaging dan proses order dapat diprioritaskan pada periode morning peak, khususnya **07:00–08:00**, ketika permintaan Takeaway dan Delivery meningkat.

---

### 4.5 Menu Revenue Contribution — Pareto Analysis

#### Business Question

> Apakah revenue Sedukopi terkonsentrasi pada sebagian kecil menu?

#### Analytical Approach

Untuk setiap menu dilakukan:

1. Menghitung total revenue.
2. Menghitung kontribusi revenue setiap menu.
3. Melakukan ranking berdasarkan revenue.
4. Menghitung cumulative revenue percentage.
5. Mengidentifikasi kelompok menu yang menghasilkan sekitar 80% revenue.

#### Key Finding

| Pareto Group           | Number of Menus | % of Menus |       Revenue | Revenue Contribution |
| ---------------------- | --------------: | ---------: | ------------: | -------------------: |
| **Top 80% Revenue**    |              48 |     68,57% | Rp315,86 juta |           **80,35%** |
| **Bottom 20% Revenue** |              22 |     31,43% |  Rp77,22 juta |           **19,65%** |
| **Total**              |              70 |       100% | Rp393,08 juta |                 100% |

Hasil analisis menunjukkan bahwa **48 dari 70 menu atau 68,57%** diperlukan untuk menghasilkan sekitar **80,35% total revenue menu**.

Dengan demikian, distribusi revenue tidak mengikuti pola 80/20 tradisional yang sangat terkonsentrasi pada sebagian kecil menu.

#### Business Implication

Hasil tersebut menunjukkan bahwa revenue relatif tersebar di seluruh portfolio menu.

Hal ini dapat menjadi dasar untuk mengevaluasi:

* Inventory priorities
* Product profitability
* Menu complexity
* Promotional focus
* Menu rationalization

---

## 5. Key Insights

### 5.1 Outlet Performance

Performa revenue antar outlet menunjukkan adanya perbedaan.

**Senopati (OUT003)** menghasilkan revenue tertinggi di antara outlet aktif sebesar **Rp25,53 juta**, sedangkan **Margonda (OUT020)** menghasilkan revenue terendah sebesar **Rp15,99 juta**.

Perbedaan tersebut dapat menjadi dasar untuk mengevaluasi customer demand, lokasi, product mix, dan operational performance.

### 5.2 Product Performance

Kategori **Coffee** menjadi kategori dengan volume penjualan terbesar dengan kontribusi **36,18% atau 3.695 unit** dari total 10.214 unit.

Produk dengan volume tinggi dapat menjadi prioritas dalam inventory availability dan operational preparation.

### 5.3 Peak Hour Performance

Aktivitas transaksi menunjukkan pola **tiga periode utama**, yaitu morning, lunch, dan evening.

Pola tersebut memberikan dasar untuk melakukan workforce scheduling dan resource allocation berdasarkan periode dengan volume transaksi tinggi.

### 5.4 Order Channel Performance

**Dine-In** mendominasi volume transaksi dengan **51,10% atau 2.555 orders**, tetapi memiliki AOV terendah sebesar **Rp77.631**.

Sebaliknya, **Delivery** memiliki volume transaksi terendah dengan **19,32% atau 966 orders**, tetapi memiliki AOV tertinggi sebesar **Rp81.306**.

Hal ini menunjukkan bahwa setiap channel memiliki karakteristik transaksi yang berbeda.

### 5.5 Menu Revenue Distribution

Sebanyak **48 dari 70 menu atau 68,57%** menghasilkan sekitar **80,35% total revenue**.

Dengan demikian, revenue Sedukopi relatif tersebar di seluruh portfolio menu dan tidak hanya bergantung pada sebagian kecil produk.

---

## 6. Business Recommendations

### 6.1 Investigate Low-Performing Outlets

Melakukan analisis lebih lanjut terhadap outlet dengan revenue lebih rendah seperti **Margonda** dan **Setia Budi Medan**.

Area yang dapat dievaluasi meliputi:

* Customer traffic
* Local demand
* Product mix
* Operating hours
* Local marketing activity

### 6.2 Prioritize High-Volume Products

Memastikan ketersediaan inventory dan kapasitas persiapan untuk produk dengan volume tinggi seperti:

* Matcha Espresso Fusion
* Croissant Butter
* Strawberry Smoothie
* Cheese Cake Slice

Prioritas tersebut terutama diperlukan selama periode peak transaction.

### 6.3 Optimize Workforce Scheduling

Menyesuaikan workforce scheduling berdasarkan pola peak hours yang ditemukan:

* **07:00–09:00**
* **12:00–14:00**
* **17:00–20:00**

Periode off-peak dapat dimanfaatkan untuk:

* Restocking
* Food preparation
* Cleaning
* Staff breaks
* Operational preparation

### 6.4 Optimize Channel Operations

Meningkatkan kesiapan packaging dan order processing pada periode dengan permintaan Takeaway dan Delivery yang tinggi, khususnya pada morning peak.

### 6.5 Evaluate Long-Tail Menu

Menggunakan hasil Pareto Analysis sebagai dasar untuk mengevaluasi menu dengan kontribusi revenue yang lebih rendah.

Evaluasi dapat digunakan untuk menentukan apakah produk perlu:

* Dipertahankan
* Dipromosikan
* Direposisi
* Digabungkan dalam bundling
* Dievaluasi kembali keberadaannya

---

## 7. Tools & Skills

### PostgreSQL

Digunakan untuk proses data querying, aggregation, dan analysis.

Technical skills yang digunakan:

* `JOIN`
* `GROUP BY`
* `ORDER BY`
* `SUM()`
* `AVG()`
* `COUNT()`
* `CASE WHEN`
* `EXTRACT()`
* Window Functions
* CTE

### Microsoft Excel

Digunakan untuk exploratory analysis, visualisasi, dan business reporting.

Skills yang digunakan:

* PivotTable
* PivotChart
* Data Visualization

### Analytical Workflow

Alur analisis yang digunakan dalam proyek:

```text
Business Questions
        ↓
Data Understanding
        ↓
Data Preparation
        ↓
SQL Query & Aggregation
        ↓
Exploratory Analysis
        ↓
Excel Visualization
        ↓
Business Insights
        ↓
Actionable Recommendations
```
