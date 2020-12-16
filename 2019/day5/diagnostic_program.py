import pandas as pd
import numpy as np

def run_algorithm(input):
    array = pd.read_csv("input", sep=',', header = None).to_numpy()[0]
    i=0
    while(i<array.size):
        if array[i]%100 == 1 or array[i]%100 == 2 \
            or array[i]%100 == 5 or array[i]%100 == 6 \
            or array[i]%100 == 7 or array[i]%100 == 8:
            if array[i]%1000 < 100:
                par1 = array[array[i+1]]
            else:
                par1 = array[i+1]
            if array[i]%10000 < 1000:
                par2 = array[array[i+2]]
            else:
                par2 = array[i+2]        

        if array[i]%100 == 1:
            array[array[i+3]] = par1 + par2
            i+=4
        elif array[i]%100 == 2:
            array[array[i+3]] = par1 * par2
            i+=4
        elif array[i]%100 == 5: #jump-if-true
            if par1 != 0:
                i=par2
            else:
                i+=3
        elif array[i]%100 == 6: #jump-if-false
            if par1 == 0:
                i=par2
            else:
                i+=3
        elif array[i]%100 == 7: #less than
            if par1<par2:
                array[array[i+3]]=1
            else:
                array[array[i+3]]=0
            i+=4
        elif array[i]%100 == 8: #equals
            if par1 == par2:
                array[array[i+3]]=1
            else:
                array[array[i+3]]=0           
            i+=4
        elif array[i]%100 == 3:
            array[array[i+1]] = input
            i+=2
        elif array[i]%100 == 4:
            print(array[array[i+1]])
            i+=2
        elif array[i]%100 == 99:
            return array[0]
            break
        else:
            print("Sth went wrong!", array[i]%100)
            return 0


if __name__ == '__main__':
    print("Task 1:")
    run_algorithm(1)
    print("Task 2:")
    run_algorithm(5)

