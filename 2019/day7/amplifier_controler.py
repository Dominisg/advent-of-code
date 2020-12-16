import pandas as pd
import numpy as np
import copy
import itertools

class Amplifier:
    def __init__(self, program):
        self.array = copy.copy(program)
        self.i = 0
        
    def run_algorithm(self, input, restart = False):
        if restart == True:
            self.i = 0
        
        if self.i > 0:
            input_index = 1
        else:
            input_index = 0
        
        output = []
        while(self.i<self.array.size):
            if self.array[self.i]%100 == 1 or self.array[self.i]%100 == 2 \
                or self.array[self.i]%100 == 5 or self.array[self.i]%100 == 6 \
                or self.array[self.i]%100 == 7 or self.array[self.i]%100 == 8:
                if self.array[self.i]%1000 < 100:
                    par1 = self.array[self.array[self.i+1]]
                else:
                    par1 = self.array[self.i+1]
                if self.array[self.i]%10000 < 1000:
                    par2 = self.array[self.array[self.i+2]]
                else:
                    par2 = self.array[self.i+2]        

            if self.array[self.i]%100 == 1:
                self.array[self.array[self.i+3]] = par1 + par2
                self.i+=4
            elif self.array[self.i]%100 == 2:
                self.array[self.array[self.i+3]] = par1 * par2
                self.i+=4
            elif self.array[self.i]%100 == 5: #jump-if-true
                if par1 != 0:
                    self.i=par2
                else:
                    self.i+=3
            elif self.array[self.i]%100 == 6: #jump-if-false
                if par1 == 0:
                    self.i=par2
                else:
                    self.i+=3
            elif self.array[self.i]%100 == 7: #less than
                if par1<par2:
                    self.array[self.array[self.i+3]]=1
                else:
                    self.array[self.array[self.i+3]]=0
                self.i+=4
            elif self.array[self.i]%100 == 8: #equals
                if par1 == par2:
                    self.array[self.array[self.i+3]]=1
                else:
                    self.array[self.array[self.i+3]]=0           
                self.i+=4
            elif self.array[self.i]%100 == 3:
                self.array[self.array[self.i+1]] = input[input_index]
                input_index+=1
                self.i+=2
            elif self.array[self.i]%100 == 4:
                output = self.array[self.array[self.i+1]]
                self.i+=2
                return output
            elif self.array[self.i]%100 == 99:
                return 0
                break
            else:
                print("Sth went wrong!", self.array[i]%100)
                return 0


if __name__ == '__main__':
    result = 0
    df = pd.read_csv("input", sep=',', header = None).to_numpy()[0]
    perms = list(itertools.permutations([0,1,2,3,4]))

    a1 = Amplifier(df)
    a2 = Amplifier(df)
    a3 = Amplifier(df)
    a4 = Amplifier(df)
    a5 = Amplifier(df)

    for i in perms:
        output = a1.run_algorithm([i[0], 0], True)#amplifier one
        output = a2.run_algorithm([i[1], output], True)#amplifier two
        output = a3.run_algorithm([i[2], output], True)#amplifier three
        output = a4.run_algorithm([i[3], output], True)#amplifier four
        output = a5.run_algorithm([i[4], output], True)#amplifier five
        if output > result:
            result = output
    print(result)

    result=0
    perms = list(itertools.permutations([5,6,7,8,9]))
    for i in perms:
        a1 = Amplifier(df)
        a2 = Amplifier(df)
        a3 = Amplifier(df)
        a4 = Amplifier(df)
        a5 = Amplifier(df)
        output = 0
        phase_result = 0
        e_output = 0
        while 1:
            output = a1.run_algorithm([i[0], output])#amplifier one
            if output == 0:
                break
            output = a2.run_algorithm([i[1], output])#amplifier two
            output = a3.run_algorithm([i[2], output])#amplifier three
            output = a4.run_algorithm([i[3], output])#amplifier four
            output = a5.run_algorithm([i[4], output])#amplifier five
            e_output = output  
        if e_output > result:
            result = e_output
        
    print(result)
