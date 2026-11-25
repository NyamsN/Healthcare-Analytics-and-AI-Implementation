# Feedback and improvements log

| Date | Source | Issue | Change made |
|---|---|---|---|
| Week 3 | Self-review | First column read as `﻿Id` because of a byte-order mark | Read all CSVs with `utf-8-sig` |
| Week 3 | Self-review | Duration looked like length of stay, but 22,328 procedures fall after encounter STOP | Treated duration as unreliable; added partial correlations controlling for procedures |
| Week 3 | Self-review | Encounter-level tests ignored repeat patients (one patient has 1,381 encounters) | Added patient-level tests, clustered SEs and a patient-cluster bootstrap |
| Week 3 | Self-review | Zero coverage by class looked meaningful | Added payer-adjusted logistic model; class pattern reverses (confounding) |
| Week 3 | Self-review | "Highest average cost" procedures were ones performed only 5–9 times | Added a version restricted to procedures performed ≥30 times |
| Week 3 | Self-review | Privacy: patients.csv contains names and addresses | Load only non-identifying columns; pseudonymous patient keys; raw data git-ignored |
| | Mentor / peer | *(add feedback here)* | |
