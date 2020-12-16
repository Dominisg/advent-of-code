import pandas as pd

def fuel_mass(fuel_amount):
    result = fuel_amount // 3 - 2
    if result < 0:
        return 0
    result += fuel_mass(result)
    return result

if __name__ == '__main__':
    df = pd.read_csv("input", sep='\n', header = None)
    sum = 0
    sum2 = 0
    for number in df[0]:
        number = number//3 - 2
        sum += number
        sum2 += number + fuel_mass(number)
    print("Task 1. result: ", sum)
    print("Task 2. result: ", sum2)
