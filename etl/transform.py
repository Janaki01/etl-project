def clean_data(df):
    print("Transforming data...")
    
    df = df.dropna()
    df.columns = [c.lower().replace(" ", "_") for c in df.columns]
    return df