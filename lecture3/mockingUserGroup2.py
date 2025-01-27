
numberUsers=0
while numberUsers <5:
    name = input("User: ")
    group = input("Group: ")

    numberUsers += 1

    if group == "ADMNISTRATION":
        print(f"User {name} belongs to the Administration group. High permissions granted.")
    else:
        print(f"User {name} does not belong to the Administration group. Limited permissions.")
