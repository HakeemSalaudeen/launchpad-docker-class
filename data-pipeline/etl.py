import pandas as pd

def main():
    # Load data
    df = pd.read_csv('fruit.csv')
    
    # Transform data
    #df['id'] = df['id2'] * 2
    df.rename(columns={'berry': 'berry_renamed'}, inplace=True)
    
    # Save transformed data
    df.to_parquet('fruit_output.parquet', index=False)
    print("ETL process completed successfully.")

if __name__ == "__main__":
    main()