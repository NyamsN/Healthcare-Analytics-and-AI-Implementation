# Healthcare Operations: Statistical Investigation of Encounter Costs

**AnalystLab Africa Experience Lab · Week 3 · Track B (Data Science)** · Intern: Nelson Nyamweya

## Purpose
A statistical investigation of a hospital's encounter, procedure, patient and payer records (Jan 2011 – Feb 2022) to answer one primary question:

> **How do recorded total claim costs differ across encounter classes, and how far are those differences associated with procedure activity, encounter duration and payer?**

Intended user: the hospital's operations and finance analytics team. Decision supported: which cost drivers to monitor alongside encounter class, and where payer-coverage gaps should be investigated.

## Deliverables
| Required | Where |
|---|---|
| 1. Reproducible Python notebook | `notebooks/Healthcare_Cost_Investigation.ipynb` (executed; HTML copy alongside). Same code as a script: `src/Healthcare_Cost_Investigation.py` |
| 2. Data-quality summary | `docs/data_quality_summary.md` and report Section 2 (tables T01–T07) |
| 3. At least five visualisations | `outputs/figures/` (11 figures, F01–F11) |
| 4. Statistical analysis report | `report/Healthcare_Cost_Statistical_Analysis_Report.pdf` (Word copy alongside) |
| 5. Findings and recommendations | Report executive summary and Section 8 (5 recommendations) |
| 6. Reproduction instructions | This README, below |

## Folder structure
```
notebooks/        executed notebook + HTML export
src/              the notebook as a plain Python script (jupytext percent format)
sql/              independent SQLite validation queries (written by the notebook)
data/raw/         put the supplied CSVs here (not committed: they contain synthetic names/addresses)
data/processed/   encounters_analysis.parquet (one row per encounter, pseudonymous patient key, no names)
outputs/figures/  11 PNG charts       outputs/tables/  34 CSV result tables
report/           statistical analysis report (PDF and Word)
docs/             data-quality summary, presentation script, social posts, feedback log
```

## How to reproduce
1. `pip install -r requirements.txt` (Python 3.10+; tested with Python 3.12, pandas 3.0, SciPy 1.18, statsmodels 0.15).
2. Copy the supplied files into `data/raw/`: `encounters.csv`, `patients.csv`, `procedures.csv`, `payers.csv`, `organizations.csv`, `data_dictionary.csv`.
   The same pack is available as "Hospital Patient Records" on the Maven Analytics Data Playground.
3. Run `jupyter notebook notebooks/Healthcare_Cost_Investigation.ipynb`, then **Kernel → Restart & Run All**, or headless:
   `jupyter nbconvert --to notebook --execute --inplace notebooks/Healthcare_Cost_Investigation.ipynb`. It takes about 30 seconds.
4. Built-in `assert` checks stop the run if a foreign key fails or if the pandas results disagree with the independent SQL check.
5. Random seed 42 (bootstrap and plot sampling), so results are identical on every run.

**Database safety:** `create_hospital_db.sql` starts with `DROP DATABASE IF EXISTS hospital_db`. It is not needed and was not run. The SQL validation uses a temporary in-memory SQLite database.

## Method
- **Inspection:** shapes, types, missing values, duplicates, key checks, dictionary-vs-CSV field check, date/duration/cost consistency, repeated patients.
- **Preparation (additive, no rows removed, no imputation):** UTC datetimes, duration, payer name and group, procedures per encounter, age at encounter, coverage flags, inconsistency flags, pseudonymous patient key.
- **EDA:** volume over time, cost distributions, cost composition, duration, payer coverage, procedure utilisation, correlations and payer mix.
- **Hypotheses:** H1 Kruskal–Wallis + Dunn (Holm); H2 Mann–Whitney per class (Holm); H3 Spearman + partial Spearman; H4 χ² + logistic regression with payer fixed effects. Effect sizes for all.
- **Multivariable check:** OLS on ln(1+cost) with patient-clustered standard errors, VIF.
- **Robustness:** patient-level re-tests, 1,000-resample patient-cluster bootstrap, outlier trimming, removing the most frequent patients.
- **Validation:** 9 key figures recomputed with independent SQL (all match).

## Success criteria (all met)
1. Key figures reconcile with an independent SQL check (9/9).
2. At least two hypotheses tested with methods matched to the data (4, rank-based, effect sizes, Holm).
3. Conclusions survive repeated-patient and outlier checks.
4. At least five relevant visualisations (11).
5. No identifying patient information in outputs.
6. Notebook reproduces end to end from the raw CSVs.

## Headline results
- 27,891 encounters, $101.5M claim cost (mean $3,640, median $279). Payers cover 30.6%; 48.7% of encounters have zero coverage.
- **H1:** class matters (p < 0.001) but only moderately (ε² = 0.07; 0.15 at patient level). Inpatient median $2,356, urgent care $143.
- **H2:** in every class, encounters with a procedure cost 1.6×–158× the median of those without (r = 0.50–1.00).
- **H3:** duration–cost link is positive but disappears in emergency and inpatient care once procedures are controlled; 69% of durations are a 15-minute default.
- **H4:** zero coverage is driven by payer (pseudo-R² 0.04 → 0.81), not class; raw class comparisons reverse after adjustment.
- Adjusted model (R² 0.60): wellness premium +141% → +23%; emergency −9% → +158%; urgent care +2% → +76% vs ambulatory.

## Assumptions and limitations
Synthetic Synthea data for one hospital; medication line items missing so totals do not reconcile with their parts; STOP times do not mark the end of care; repeated patients (top 10 = 20.6% of encounters); no diagnosis severity or claim status. All findings are associations, not causal effects or clinical evidence. Full list in report Section 7.

## Privacy and responsible use
Only non-identifying patient columns are loaded; names, addresses, birthplace and coordinates are never read. Patient identifiers in outputs are pseudonymous (`P0001`…). Raw data is excluded from version control. No clinical claims or treatment recommendations are made.

## Attribution
Dataset: Hospital Patient Records (Maven Analytics), supplied by AnalystLab Africa; generated with Synthea (Walonoski et al., 2018, *JAMIA* 25(3):230–238, doi:10.1093/jamia/ocx079). Libraries: pandas, NumPy, SciPy, statsmodels, scikit-posthocs, Matplotlib, Seaborn. AI assistance (Claude) was used to help draft code and documentation.
