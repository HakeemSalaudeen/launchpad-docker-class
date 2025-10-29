import pandas as pd

def main():
    # Load data
    df = pd.read_csv('fruit.csv')
    
    # Transform data
    df.rename(columns={'berry': 'berry_renamed'}, inplace=True)
    
    # Save transformed data to the mounted output directory
    df.to_csv('output/fruit_output.csv', index=False)
    print("ETL process completed successfully.")

if __name__ == "__main__":
    main()