# Video presentation script (about 8 minutes)

Screen-share the report PDF or the notebook HTML.

**1. Intro (0:00–0:40).** "Hi, I'm Nelson Nyamweya, Data Science track, Week 3. I investigated what drives encounter costs at a hospital, using 27,891 encounters, 974 patients and 47,701 procedure records from 2011 to 2022. My question: how do claim costs differ across encounter classes, and how much of that is really about procedures, duration and payer?"

**2. Data quality (0:40–2:00).** Section 2. "All keys match, no duplicates. But three things shaped the analysis. First, duration isn't length of stay: 69% of encounters are a default 15 minutes and 22,000 procedures are time-stamped after the encounter ended. Second, claim totals don't add up to their parts, because medications aren't in the files. Third, repeat patients: ten people produce a fifth of all encounters. So I checked every test at patient level too. I also never loaded patient names or addresses."

**3. EDA (2:00–3:30).** Figures 2, 3 and 5. "Costs are extremely skewed: median $279, mean $3,640. Inpatient is most expensive by median, urgent care the cheapest, yet urgent care has the second-highest mean because of a costly tail. Procedure activity tracks cost: 92% of inpatient encounters have a procedure, only 28% of urgent care. And zero coverage is about payer: four private insurers show zero coverage on almost every encounter."

**4. Hypotheses (3:30–5:30).** Table 8, Figure 8. "I used rank-based tests because the data is skewed and groups are unequal. H1: class matters, but the effect is medium; it explains 7 to 15% of cost variation. H2: in every class, encounters with a procedure cost far more, up to 158 times the median in urgent care. H3: duration is positively linked to cost, but in emergency and inpatient care that disappears once you control for procedures. H4: zero coverage differs by class only slightly; payer explains almost all of it, and the class comparison even reverses after adjusting for payer."

**5. Model and robustness (5:30–6:40).** Figures 9 and 10. "A regression with patient-clustered errors shows the wellness premium mostly disappears, and emergency and urgent care flip from cheap to expensive once procedures are held constant. Every conclusion holds at patient level, without outliers and without the most frequent patients, and nine key numbers match an independent SQL check."

**6. Limitations and recommendations (6:40–8:00).** "The data is synthetic, so these are patterns in this dataset, not clinical evidence, and everything is association, not causation. My recommendations: report cost by class together with procedure activity; review zero coverage by payer contract, starting with the four insurers; monitor the high-cost tail in urgent and emergency care; fix encounter timestamps; and analyse at patient level. Thank you."
