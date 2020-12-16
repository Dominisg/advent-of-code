import pandas as pd
import numpy as np

def run_algorithm(input):
    array = pd.read_csv("input", sep=',', header = None).to_numpy()[0]
    array = np.append(array, [0 for _ in range(2000)]) # add something to memory
    i=0
    base = 0
    while(i<array.size):

        if array[i]%1000 < 100:
            par1 = array[array[i+1]:array[i+1]+1]
        elif array[i]%1000 < 200:
            par1 = [array[i+1]]
        else:
            par1 = array[array[i+1] + base : array[i+1] + base+1]
            
        if array[i]%10000 < 1000:
            par2 = array[array[i+2] : array[i+2]+1]
        elif array[i]%10000 < 2000:
            par2 = [array[i+2]]
        else:
            par2 = array[array[i+2] + base : array[i+2] + base + 1]

        if array[i]%100000 < 10000:
            par3 = array[array[i+3] : array[i+3]+1]
        else:
            par3 = array[array[i+3] + base:array[i+3] + base + 1]


        if array[i]%100 == 1:
            par3[0] = par1[0] + par2[0]
            i+=4
        elif array[i]%100 == 2:
            par3[0] = par1[0] * par2[0]
            i+=4
        elif array[i]%100 == 5: #jump-if-true
            if par1[0] != 0:
                i=par2[0]
            else:
                i+=3
        elif array[i]%100 == 6: #jump-if-false
            if par1[0] == 0:
                i=par2[0]
            else:
                i+=3
        elif array[i]%100 == 7: #less than
            if par1[0]<par2[0]:
                par3[0]=1
            else:
                par3[0]=0
            i+=4
        elif array[i]%100 == 8: #equals
            if par1[0] == par2[0]:
                par3[0]=1
            else:
                par3[0]=0           
            i+=4
        elif array[i]%100 == 9: #adjusts the relative base
            base += par1[0]
            i+=2
        elif array[i]%100 == 3:
            par1[0] = input
            i+=2
        elif array[i]%100 == 4:
            print(par1[0])
            i+=2
        elif array[i]%100 == 99:
            return array[0]
        else:
            print("Sth went wrong!", array[i]%100)
            return 0


if __name__ == '__main__':
    print("Task 1:")
    run_algorithm(1)
    print("Task 2:")
    run_algorithm(2)


