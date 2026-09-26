# Customer Support Quality Analysis — Practical Exam (Set B)

**Student Name:** Bhatti Pushkar
**Student ID:** 11156
**Assigned Set:** Set B
**Course:** Data Analysis — Excel • Power BI • SQL • Python

---

## 📜 A Word of Introduction (in the Old English Manner)

Good morrow, esteemed Examiner. Herein lies presented, with due diligence and no small measure of cheek, the humble works of one Bhatti Pushkar — student, number eleven-thousand-one-hundred-and-fifty-six upon your rolls — who did set forth upon the thorny business of Customer Support Quality, armed with naught but four CSV rows, a duplicate ticket most impertinent, and the steadfast conviction that Jan must always precede Feb, and Feb must always precede Mar, come what may.

Four tools were summoned to this labour — Excel, most dutiful of ledger-keepers; SQL, stern arbiter of joins and keys; Python, tireless and uncomplaining; and Power BI, ever fond of a well-placed slicer. Each was made to answer the selfsame question, that their answers might agree, as good colleagues ought. And agree they did — to two decimal places, no less, which this candidate considers no small feat of civility among machines.

What follows, then, is the record of that undertaking: plain in its facts, precise in its figures, and — the candidate hopes — pleasing enough to the eye of one who must mark fifty such reports before luncheon.

---

## 🎯 Business Objective

**Business question:** Which support team should improve resolution performance, and how does service quality vary by channel?

**Two business questions answered:**
1. Which department/team has the weakest resolution performance and SLA compliance?
2. How does SLA breach behaviour differ across support channels (Email, Chat, Phone)?

---

## 📁 Dataset & Data Dictionary

| File | Rows | Purpose |
|---|---|---|
| `Datasets/tickets.csv` | 13 (incl. 1 duplicate) | Fact table — one row per support ticket |
| `Datasets/teams.csv` | 4 | Lookup table — team metadata |

**tickets.csv**

| Column | Type | Meaning |
|---|---|---|
| ticket_id | Integer | Unique ticket identifier |
| month | Text (ordered: Jan → Feb → Mar) | Month ticket was logged |
| team_id | Text | Foreign key to teams.team_id |
| channel | Text | Support channel: Email, Chat, Phone |
| resolution_hours | Numeric | Hours taken to resolve the ticket |
| satisfaction | Numeric (1–5) | Customer satisfaction score |

**teams.csv**

| Column | Type | Meaning |
|---|---|---|
| team_id | Text | Unique team identifier |
| team | Text | Team name |
| department | Text | Service or Technical |

---

## 🧹 Cleaning Steps & Metric Definitions

- Row 12 of `tickets.csv` (ticket_id 12, T4, Phone, 24h) was an exact duplicate. It was removed in every module — **13 raw rows → 12 clean rows**.
- **breach_flag** = `1` when `resolution_hours > 24`, else `0`. A ticket resolved in exactly 24 hours meets the SLA and is **not** a breach.
- **SLA breach rate** = (tickets with `breach_flag = 1`) ÷ (all tickets), calculated from underlying counts — never averaged from subgroup percentages.
- `month` is treated as an ordered category (Jan → Feb → Mar) in every chart and pivot.

---

## 🛠 Tools & Versions Used

| Tool | Version (fill in your actual version) |
|---|---|
| Excel | Microsoft 365 |
| Power BI Desktop | Latest (Windows) |
| SQL Engine | MySQL 8.0 *(update to match what you used)* |
| Python | 3.x — pandas, matplotlib |

---

## 📂 Project Folder Structure

```
data-analysis-set-e-11156/
├── README.md
├── requirements.txt
├── .gitignore
├── data/
│   └── raw/
│       ├── tickets.csv
│       └── teams.csv
├── excel/
│   └── analysis.xlsx          (Raw, Lookup, Clean, Summary sheets)
├── sql/
│   ├── setup.sql
│   └── queries.sql            (S2a, S2b, S2c)
├── python/
│   └── analysis.py            (or analysis.ipynb)
├── powerbi/
│   └── dashboard.pbix
└── outputs/
    ├── clean_data.csv
    ├── python_summary.csv
    ├── python_chart.png
    ├── powerbi_dashboard.png
    └── sql/
        ├── s2a_avg_resolution_by_department.csv
        ├── s2b_teams_breaching_sla.csv
        └── s2c_top_channels_by_breach.csv
```

---

## 🗄 SQL Setup & Execution

1. Run `sql/setup.sql` first — creates `tickets` and `teams` tables (with PK/FK constraint) and loads exactly 12 fact rows + 4 lookup rows.
2. Run `sql/queries.sql` second — executes S2a, S2b, S2c and the LEFT JOIN integrity check.
3. SQL dialect and version are documented as a comment at the top of `setup.sql`.

---

## 🐍 Python Setup & Run Instructions

```bash
pip install -r requirements.txt
python python/analysis.py
```

All paths are relative to the repository root, so the script runs unmodified after cloning.

---

## 📗 Excel Sheet Guide

| Sheet | Contents |
|---|---|
| Raw | Original 13-row `tickets.csv`, unchanged |
| Lookup | 4-row `teams.csv` |
| Clean | 12-row deduplicated data, `department` via XLOOKUP, `breach_flag` via IF formula |
| Summary | COUNTIFS breach table by channel, PivotTable (department × month), column chart |

---

## 📊 Power BI Data-Source Refresh Instructions

The `.pbix` reads `Datasets/tickets.csv` and `Datasets/teams.csv` via relative paths. After cloning the repository to a new machine:
1. Open `powerbi/dashboard.pbix`.
2. Go to **Transform Data → Data Source Settings**.
3. Update the file path to point at the local `Dataset/Tickets.csv,Teams.csv` folder.
4. Click **Refresh**.

---

## 📈 Findings

1. **Team-level SLA breach:** T2 (BillingHelp), T3 (AppSupport) and T4 (DeviceHelp) are tied for the highest per-team SLA breach rate at **66.67%** each (2 of 3 tickets breached), while T1 (AccountCare) had **0%** breaches. At department level, the **Technical department** (T3+T4) breaches SLA at **50.00%**, nearly double the **Service department**'s **33.33%** — so Technical is the department most in need of resolution-time improvement.
2. **Channel-level breach:** **Chat** has the highest breach count (3 of 4 tickets breach SLA), followed by **Phone** (2 of 4). **Email** had **zero** SLA breaches across all 4 tickets — the most reliable channel for timely resolution.

**Recommendation:** Prioritise process improvement in the Technical department (particularly teams T3 and T4) and investigate root causes of delay in the Chat channel, since it carries the highest breach rate of any channel.

**Limitation:** The dataset is small (12 tickets across 3 months), so team- and channel-level rates rest on very few observations per group; results should be treated as directional rather than statistically robust.

---

## 🔗 Cross-Tool Reconciliation

**Chosen aggregate:** Average `resolution_hours` for the **Technical** department.

| Tool | Value |
|---|---|
| Excel (PivotTable / COUNTIFS-derived) | 28.33 |
| SQL (S2a query) | 28.33 |
| Python (department summary) | 28.33 |
| Power BI (KPI card filtered to Technical) | 28.33 |

All four tools agree to two decimal places. No rounding differences were observed.

*(Overall dataset reference figures for cross-checking: overall SLA breach rate = 41.67%, overall average resolution_hours = 23.83, overall average satisfaction = 3.58.)*

---

## 📚 References

*No external code or datasets were used beyond those supplied for this exam. (Update this section if you referenced any external resource.)*

---

## ✅ Authorship Declaration

All work in this repository is my own except where cited.

**— Bhatti Pushkar (Student ID: 11156)**
