import pandas as pd
df = pd.DataFrame([{"Name": "Alice", "Age": 30}, {"Name": "Bob", "Age": 25}])
print(df.to_string(index=False))