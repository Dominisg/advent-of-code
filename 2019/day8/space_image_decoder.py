import math

IMG_WIDTH = 25
IMG_HEIGHT = 6
IMG_SIZE = IMG_WIDTH*IMG_HEIGHT

if __name__ == '__main__':
    with open('input', 'r') as content_file:
        content = content_file.read()
        zero_counter = 0
        one_counter = 0
        two_counter = 0
        zeros_in_layers = []
        for i, pixel in enumerate(content):
            if pixel == '0':
                zero_counter+=1
            if i % IMG_SIZE == 0 and i != 0:
                print(i)
                zeros_in_layers.append(zero_counter)
                zero_counter = 0

        min = math.inf
        min_index = 0
        for i, n in enumerate(zeros_in_layers):
            if n < min:
                min = n
                min_index = i
    
        for i in range(min_index*IMG_SIZE,(min_index+1)*IMG_SIZE):
            if content[i] == '1':
                one_counter+=1
            elif content[i] == '2':
                two_counter+=1
    
        print("Task 1 result:", one_counter * two_counter)
        
        result = [9 for i in range(IMG_SIZE)]
        for i in range(IMG_SIZE):
            for j in range(len(zeros_in_layers)):
                if content[j*IMG_SIZE + i] != '2':
                    result[i] = content[j*IMG_SIZE + i]
                    print(content[j*IMG_SIZE + i])
                    break;
        
        print("Task 2 resut:")
        for i in range(IMG_SIZE):
            if result[i] == '0':
                print('.', end='')
            elif result[i] == '1':
                print('*', end='')
            if(i % IMG_WIDTH == IMG_WIDTH-1 and i != 0):
                print('')
