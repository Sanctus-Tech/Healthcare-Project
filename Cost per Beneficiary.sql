SELECT
    brnd_name,
    gnrc_name,
    ROUND(SUM(tot_spndng_2018) / NULLIF(SUM(tot_benes_2018), 0), 2) AS cost_per_bene_2018,
    ROUND(SUM(tot_spndng_2019) / NULLIF(SUM(tot_benes_2019), 0), 2) AS cost_per_bene_2019,
    ROUND(SUM(tot_spndng_2020) / NULLIF(SUM(tot_benes_2020), 0), 2) AS cost_per_bene_2020,
    ROUND(SUM(tot_spndng_2021) / NULLIF(SUM(tot_benes_2021), 0), 2) AS cost_per_bene_2021,
    ROUND(SUM(tot_spndng_2022) / NULLIF(SUM(tot_benes_2022), 0), 2) AS cost_per_bene_2022
FROM medicare_drug_spending
WHERE tot_benes_2018 > 0 OR tot_benes_2019 > 0 OR tot_benes_2020 > 0 
   OR tot_benes_2021 > 0 OR tot_benes_2022 > 0
GROUP BY brnd_name, gnrc_name
ORDER BY cost_per_bene_2022 DESC;