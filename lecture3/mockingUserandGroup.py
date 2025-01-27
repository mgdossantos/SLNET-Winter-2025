name = input("User: ")
group = input("Group: ")

if group == "ADMNISTRATION":
    print(f"User {name} belongs to the Administration group. High permissions granted.")
else:
    print(f"User {name} does not belong to the Administration group. Limited permissions.")
