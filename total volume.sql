SELECT
    brnd_name,
    gnrc_name,
    SUM(tot_dsg_unts_2018) AS total_volume_2018,
    SUM(tot_dsg_unts_2019) AS total_volume_2019,
    SUM(tot_dsg_unts_2020) AS total_volume_2020,
    SUM(tot_dsg_unts_2021) AS total_volume_2021,
    SUM(tot_dsg_unts_2022) AS total_volume_2022
FROM medicare_drug_spending
GROUP BY brnd_name, gnrc_name
ORDER BY total_volume_2022 DESC;