import streamlit as st
import pandas as pd
import json
import os

st.set_page_config(page_title="1stStep AI Scout", layout="wide")
st.title("🚀 1stStep AI: Viral Scout Engine")

# Load Data logic
def load_data():
    if os.path.exists('scout_output.json'):
        with open('scout_output.json', 'r') as f:
            return json.load(f)
    return []

data = load_data()

if not data:
    st.warning("⚠️ No live data found. Generating sample data for testing...")
    data = [{"name": "Sample Product", "retail": 49.99, "landed": 15.00, "profit": 25.00, "score": 8}]

df = pd.DataFrame(data)

# Interactive UI for Users
st.sidebar.header("User Controls")
ad_spend = st.sidebar.slider("Daily Ad Spend ($)", 0, 500, 50)

st.write("### Live Market Arbitrage")
st.dataframe(df.style.highlight_max(axis=0, subset=['profit'], color='#2E7D32'))

# Interactive Logic
st.write("---")
st.subheader("💡 2026 Strategy Insight")
for item in data:
    with st.expander(f"Analyze {item['name']}"):
        st.write(f"This product has a **Trust Score of {item['score']}/10**.")
        st.write(f"At ${ad_spend} daily spend, estimated monthly net is **${(item['profit'] * 10) - ad_spend:.2f}**.")