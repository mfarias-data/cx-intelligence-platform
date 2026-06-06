# Data Dictionary

## Fact_Interactions

| Column | Description |
|----------|-------------|
| InteractionID | Unique interaction identifier |
| InteractionDateTime | Interaction timestamp |
| CustomerID | Customer identifier |
| AgentID | Agent responsible |
| ChannelID | Contact channel |
| CategoryID | Contact category |
| DurationSeconds | Interaction duration |
| ResolutionStatus | Resolution status |
| ReopenedFlag | Indicates reopened interaction |
| SatisfactionScore | Customer satisfaction score |

---

## Dim_Agent

| Column | Description |
|----------|-------------|
| AgentID | Agent identifier |
| AgentName | Agent name |
| TeamLeader | Team leader |
| Department | Business unit |

---

## Dim_Channel

| Column | Description |
|----------|-------------|
| ChannelID | Channel identifier |
| ChannelName | Channel name |
| IsDigital | Digital channel flag |

---

## Dim_Category

| Column | Description |
|----------|-------------|
| CategoryID | Category identifier |
| CategoryName | Category description |

---

## Dim_Calendar

| Column | Description |
|----------|-------------|
| DateKey | Calendar date |
| CalendarYear | Year |
| CalendarMonth | Month number |
| MonthName | Month name |
| QuarterNumber | Quarter number |
