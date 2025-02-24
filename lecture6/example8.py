import json
from tabulate import tabulate
from colorama import Fore, Style

students = [{"Name": "Alice", "Grade": 85}, {"Name": "Bob", "Grade": 45}]

# Pretty-print JSON
print(json.dumps(students, indent=4))

# Tabulate output
print(tabulate(students, headers="keys", tablefmt="grid"))

# Warning for low grades
for student in students:
    if student["Grade"] < 50:
        print(Fore.RED + f"Warning: {student['Name']} is failing!" + Style.RESET_ALL)