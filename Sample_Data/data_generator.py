import pandas as pd
import numpy as np
import uuid
from datetime import datetime, timedelta

# ==========================================
# CONFIG
# ==========================================

np.random.seed(42)

N_ROWS = 20000

START_DATE = datetime(2026, 1, 1)
END_DATE = datetime(2026, 5, 31)

# ==========================================
# Aux Functions
# ==========================================

def random_dates(start, end, n):
    delta = end - start
    total_seconds = int(delta.total_seconds())

    random_seconds = np.random.randint(
        0,
        total_seconds,
        n
    )

    return [
        start + timedelta(seconds=int(sec))
        for sec in random_seconds
    ]

# ==========================================
# Agents Dimensions
# ==========================================

agents = list(range(101, 141))

agent_dimension = []

for agent in agents:

    if agent <= 110:
        leader = "Supervisor Alpha"

    elif agent <= 120:
        leader = "Supervisor Beta"

    elif agent <= 130:
        leader = "Supervisor Gamma"

    else:
        leader = "Supervisor Delta"

    agent_dimension.append({
        "agent_id": agent,
        "agent_name": f"Agent {agent}",
        "team_leader": leader,
        "department": "Customer Service"
    })

agent_dimension = pd.DataFrame(agent_dimension)

# ==========================================
# Domains
# ==========================================

channels = [
    "Chat",
    "Voice",
    "Email",
    "Bot"
]

channel_probs = [
    0.40,
    0.30,
    0.20,
    0.10
]

categories = [
    "Technical Support",
    "Billing",
    "Shipping",
    "Product Information",
    "Software Update",
    "Account Access"
]

# ==========================================
# DATASET BASE
# ==========================================

df = pd.DataFrame({

    "interaction_id": [
        str(uuid.uuid4())
        for _ in range(N_ROWS)
    ],

    "timestamp": random_dates(
        START_DATE,
        END_DATE,
        N_ROWS
    ),

    "channel": np.random.choice(
        channels,
        N_ROWS,
        p=channel_probs
    ),

    "category": np.random.choice(
        categories,
        N_ROWS
    ),

    "customer_id": np.random.randint(
        10000,
        18000,
        N_ROWS
    ),

    "agent_id": np.random.choice(
        agents,
        N_ROWS
    )
})

# ==========================================
# BOT HAS NO HUMAN AGENT
# ==========================================

df.loc[
    df["channel"] == "Bot",
    "agent_id"
] = 999

# ==========================================
# ENRICH WITH AGENT DIM
# ==========================================

df = df.merge(
    agent_dimension,
    on="agent_id",
    how="left"
)

df.loc[
    df["channel"] == "Bot",
    "agent_name"
] = "Virtual Assistant"

df.loc[
    df["channel"] == "Bot",
    "team_leader"
] = "Automation"

df.loc[
    df["channel"] == "Bot",
    "department"
] = "Digital Support"

# ==========================================
# DURATION PER CHANNEL
# ==========================================

def duration_by_channel(channel):

    if channel == "Voice":
        return max(
            30,
            int(np.random.normal(450, 100))
        )

    elif channel == "Chat":
        return max(
            30,
            int(np.random.normal(600, 150))
        )

    elif channel == "Email":
        return max(
            30,
            int(np.random.normal(300, 80))
        )

    elif channel == "Bot":
        return max(
            10,
            int(np.random.normal(120, 30))
        )

df["duration_seconds"] = df["channel"].apply(
    duration_by_channel
)

# ==========================================
# INITIAL STATUS
# ==========================================

df["resolution_status"] = np.random.choice(
    ["Resolved", "Unresolved", "Transferred"],
    N_ROWS,
    p=[0.78, 0.12, 0.10]
)

df["reopened_flag"] = np.random.choice(
    [0, 1],
    N_ROWS,
    p=[0.90, 0.10]
)

# ==========================================
# Business Problem Simulation
# ==========================================
#
# Canal: Bot
# Categoria: Software Update
#
# Abril -> Moderated degradation
# Maio -> Severe degradation
#
# ==========================================

mask_april = (
    (df["channel"] == "Bot")
    &
    (df["category"] == "Software Update")
    &
    (df["timestamp"].dt.month == 4)
)

mask_may = (
    (df["channel"] == "Bot")
    &
    (df["category"] == "Software Update")
    &
    (df["timestamp"].dt.month == 5)
)

april_idx = df[mask_april].sample(
    frac=0.40,
    random_state=42
).index

df.loc[
    april_idx,
    "resolution_status"
] = "Unresolved"

df.loc[
    april_idx,
    "reopened_flag"
] = 1

may_idx = df[mask_may].sample(
    frac=0.70,
    random_state=42
).index

df.loc[
    may_idx,
    "resolution_status"
] = "Unresolved"

df.loc[
    may_idx,
    "reopened_flag"
] = 1

# ==========================================
# CSAT - Customer Satisfaction
# ==========================================

def generate_csat(status):

    if status == "Resolved":
        return np.random.choice(
            [4, 5],
            p=[0.30, 0.70]
        )

    elif status == "Unresolved":
        return np.random.choice(
            [1, 2, 3],
            p=[0.50, 0.30, 0.20]
        )

    else:
        return np.random.choice(
            [2, 3, 4],
            p=[0.20, 0.60, 0.20]
        )

df["satisfaction_score"] = df[
    "resolution_status"
].apply(generate_csat)

# ==========================================
# EXPORTATION
# ==========================================

OUTPUT_FILE = "omnichannel_interactions.csv"

df.to_csv(
    OUTPUT_FILE,
    index=False
)

# ==========================================
# RESUME
# ==========================================

print("=" * 60)
print("DATASET GENERATED SUCCESSFULLY")
print("=" * 60)
print(f"Rows: {len(df):,}")
print(f"File: {OUTPUT_FILE}")
print("=" * 60)

print("\nColumns:")
for col in df.columns:
    print(f"- {col}")

print("\nSample:")
print(df.head())
