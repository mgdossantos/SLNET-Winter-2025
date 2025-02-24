from tabulate import tabulate
data = [["Alice", 30], ["Bob", 25]]
print(tabulate(data, headers=["Name", "Age"], tablefmt="grid"))