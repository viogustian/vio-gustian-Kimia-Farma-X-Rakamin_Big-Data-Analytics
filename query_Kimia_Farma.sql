/* membuat tabel untuk analisa*/
SELECT 
transaction_id, 
date, 
`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.branch_id, 
branch_name, 
kota, provinsi, 
`rakamin-kf-analytics-416005.kimia_farma.kf_kantor_cabang`.rating AS rating_cabang, 
customer_name, 
`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.product_id, 
product_name, 
`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price AS actual_price, 
discount_percentage,

CASE /* membuat kondisi */
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <= 50000 THEN 0.10
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 50000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=100000 THEN 0.15
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 100000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=300000 THEN 0.20
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 300000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=500000 THEN 0.25
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 500000 THEN 0.30
END AS persentase_gross_laba,

CASE
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <= 50000 THEN (1.00-discount_percentage)*(1.10*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 50000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=100000 THEN (1.00-discount_percentage)*(1.15*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 100000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=300000 THEN (1.00-discount_percentage)*(1.20*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 300000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=500000 THEN (1.00-discount_percentage)*(1.25*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 500000 THEN (1.00-discount_percentage)*(1.30*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)
END AS nett_sales,
CASE
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <= 50000 THEN (1.00-discount_percentage)*(1.10*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)-`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 50000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=100000 THEN (1.00-discount_percentage)*(1.15*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)-`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 100000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=300000 THEN (1.00-discount_percentage)*(1.20*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)-`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 300000 AND `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price <=500000 THEN (1.00-discount_percentage)*(1.25*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)-`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price
  WHEN `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price > 500000 THEN (1.00-discount_percentage)*(1.30*`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price)-`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.price
END AS nett_profit,
`rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.rating AS rating_transaksi

/* menggabungkan data dari table lain dengan fungsi join */

FROM `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction` 
JOIN `rakamin-kf-analytics-416005.kimia_farma.kf_kantor_cabang`
ON `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.branch_id = `rakamin-kf-analytics-416005.kimia_farma.kf_kantor_cabang`.branch_id
JOIN `rakamin-kf-analytics-416005.kimia_farma.kf_product`
ON `rakamin-kf-analytics-416005.kimia_farma.kf_final_transaction`.product_id = `rakamin-kf-analytics-416005.kimia_farma.kf_product`.product_id
