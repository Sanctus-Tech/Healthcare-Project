SELECT
    brnd_name,
    gnrc_name,
    SUM(tot_spndng_2018) AS total_spending_2018,
    SUM(tot_spndng_2019) AS total_spending_2019,
    SUM(tot_spndng_2020) AS total_spending_2020,
    SUM(tot_spndng_2021) AS total_spending_2021,
    SUM(tot_spndng_2022) AS total_spending_2022
FROM medicare_drug_spending
GROUP BY brnd_name, gnrc_name
ORDER BY total_spending_2022 DESC;