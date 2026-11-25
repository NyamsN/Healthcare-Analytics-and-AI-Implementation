-- Independent validation queries (SQLite). Run against the raw CSVs loaded as tables.

-- total_encounters
SELECT COUNT(*) FROM encounters;

-- zero_coverage_encounters
SELECT COUNT(*) FROM encounters WHERE CAST(PAYER_COVERAGE AS REAL) = 0;

-- over_24h_encounters
SELECT COUNT(*) FROM encounters WHERE (julianday(STOP) - julianday(START)) * 24 > 24;

-- total_claim_cost_sum
SELECT ROUND(SUM(CAST(TOTAL_CLAIM_COST AS REAL)), 2) FROM encounters;

-- inpatient_encounters
SELECT COUNT(*) FROM encounters WHERE ENCOUNTERCLASS = 'inpatient';

-- encounters_with_procedure
SELECT COUNT(DISTINCT ENCOUNTER) FROM procedures;

-- medicare_avg_total_claim_cost
SELECT ROUND(AVG(CAST(e.TOTAL_CLAIM_COST AS REAL)), 2) FROM encounters e JOIN payers p ON e.PAYER = p.Id WHERE p.NAME = 'Medicare';

-- encounters_2014
SELECT COUNT(*) FROM encounters WHERE substr(START, 1, 4) = '2014';

-- most_frequent_procedure_count
SELECT COUNT(*) AS n FROM procedures GROUP BY DESCRIPTION ORDER BY n DESC LIMIT 1;
