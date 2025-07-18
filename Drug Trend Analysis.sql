WITH yearly_totals AS (
    SELECT
        brnd_name,
        gnrc_name,
        SUM(tot_spndng_2018) AS spending_2018,
        SUM(tot_spndng_2019) AS spending_2019,
        SUM(tot_spndng_2020) AS spending_2020,
        SUM(tot_spndng_2021) AS spending_2021,
        SUM(tot_spndng_2022) AS spending_2022
    FROM medicare_drug_spending
    GROUP BY brnd_name, gnrc_name
)
SELECT
    brnd_name,
    gnrc_name,
    spending_2018,
    spending_2019,
    spending_2020,
    spending_2021,
    spending_2022,
    ROUND((spending_2019 - spending_2018) / NULLIF(spending_2018, 0) * 100, 2) AS yoy_growth_2019,
    ROUND((spending_2020 - spending_2019) / NULLIF(spending_2019, 0) * 100, 2) AS yoy_growth_2020,
    ROUND((spending_2021 - spending_2020) / NULLIF(spending_2020, 0) * 100, 2) AS yoy_growth_2021,
    ROUND((spending_2022 - spending_2021) / NULLIF(spending_2021, 0) * 100, 2) AS yoy_growth_2022
FROM yearly_totals
ORDER BY yoy_growth_2022 DESC;