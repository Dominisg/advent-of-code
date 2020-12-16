if __name__ == '__main__':
    f = open("input", "r")
    content = f.read()
    content = content.split('-')
    data = [int(x) for x in content]
    
    first_criteria = set()
    second_criteria = set()

    for i in range(data[0], data[1]+1):
        number = str(i)
        if int(number[0])<=int(number[1])<=int(number[2])<=int(number[3])<=int(number[4])<=int(number[5]):
            for j in range(0,5):
                if number[j] == number[j+1]:
                    first_criteria.add(i)                
                if number.count(number[j]) == 2:
                    second_criteria.add(i)

    print("Task 1 result:", len(first_criteria))
    print("Task 2 result:", len(second_criteria))
