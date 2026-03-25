import streamlit as st
import pandas as pd
import json
import os

# --- 1. PAGE CONFIGURATION ---
st.set_page_config(
    page_title="1stStep AI | 2026 Product Scout", 
    page_icon="🚀", 
    layout="wide"
)

# --- 2. CUSTOM STYLING ---
st.markdown("""
    <style>
    .main { background-color: #f8f9fa; }
    .stMetric { 
        background-color: #ffffff; 
        padding: 20px; 
        border-radius: 12px; 
        box-shadow: 0 4px 6px rgba(0,0,0,0.05); 
    }
    </style>
    """, unsafe_allow_html=True)

# --- 3. DATA LOADING FUNCTION ---
@st.cache_data(ttl=60)
def load_data():
    file_path = 'scout_output.json'
    if os.path.exists(file_path):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                return pd.DataFrame(json.load(f))
        except (json.JSONDecodeError, ValueError):
            st.error("Data file (JSON) is corrupted.")
            return pd.DataFrame()
    return pd.DataFrame(columns=["Product", "Category", "Cost", "Retail", "Trust_Score"])

# --- 4. SIDEBAR SETTINGS ---
st.sidebar.title("🛠️ Control Center")
st.sidebar.info("Data Engine: 1stStep AI v4.2 | Live March 2026")

commission_fee = st.sidebar.slider("TikTok Shop Fee (%)", 0.0, 15.0, 7.02)
fulfillment_cost = st.sidebar.number_input("Fulfillment (FBT) $", value=3.58)

# --- 5. MAIN DASHBOARD LOGIC ---
st.title("🚀 1stStep AI: Product Scout")
df = load_data()

if not df.empty:
    # A. Calculations (Ensure column names match JSON)
    df['Fees'] = df['Retail'] * (commission_fee / 100)
    df['Net Profit'] = df['Retail'] - df['Cost'] - df['Fees'] - fulfillment_cost
    df['Margin %'] = (df['Net Profit'] / df['Retail']) * 100

    # B. Search Bar
    search_query = st.text_input("🔍 Search by Product or Category:")

    if search_query:
        df = df[
            df['Product'].str.contains(search_query, case=False, na=False) | 
            df['Category'].str.contains(search_query, case=False, na=False)
        ]

    # C. Display Metrics & Table
    if not df.empty:
        m1, m2, m3 = st.columns(3)
        m1.metric("Top Result", df['Product'].iloc[0])
        m2.metric("Avg. Trust Score", f"{df['Trust_Score'].mean():.1f}%")
        # Fixed the column name to 'Net Profit' for the highlight function
        m3.metric("Highest Margin", f"{df['Margin %'].max():.1f}%")

        st.write(f"### Found {len(df)} Winning Opportunities")
        
        st.dataframe(
            df.style.format({
                "Cost": "${:.2f}", 
                "Retail": "${:.2f}", 
                "Net Profit": "${:.2f}", 
                "Margin %": "{:.1f}%"
            }).highlight_max(axis=0, subset=['Net Profit'], color='#d4edda'),
            use_container_width=True
        )
    else:
        st.warning(f"No products found matching '{search_query}'.")
else:
    st.warning("No data found. Ensure scout_output.json is populated.")

st.divider()
st.caption("1stStep AI Proprietary Scouting Engine | Last Updated: March 25, 2026")