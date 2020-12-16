import pandas as pd
import numpy as np

class robot:

    def __init__(self, white = 0):
        self.i = 0
        self.base = 0
        self.array = pd.read_csv("input", sep=',', header = None).to_numpy()[0]
        self.array = np.append(self.array, [0 for _ in range(2000)]) # add something to memory
        self.cur_dir = 1
        self.painted = set()
        if white:
            self.x = 5
            self.y = 5
            self.map = np.zeros([15,55])
            self.map[self.x][self.y] = 1
        else:
            self.x = 50
            self.y = 50
            self.map = np.zeros([150,150])

    def turn(self, right):
        if(right):
            self.cur_dir += 1
            if self.cur_dir == 5:
                self.cur_dir = 1
        else:
            self.cur_dir -= 1
            if self.cur_dir == 0:
                self.cur_dir = 4
        
        if self.cur_dir == 1: # up
            self.y -= 1
        if self.cur_dir == 2: #right
            self.x += 1
        if self.cur_dir == 3: # down
            self.y += 1
        if self.cur_dir == 4: #left
            self.x -= 1
        
    def run_algorithm(self):
        which_output=0
        while(self.i<self.array.size):

            if self.array[self.i]%1000 < 100:
                par1 = self.array[self.array[self.i+1]:self.array[self.i+1]+1]
            elif self.array[self.i]%1000 < 200:
                par1 = [self.array[self.i+1]]
            else:
                par1 = self.array[self.array[self.i+1] + self.base : self.array[self.i+1] + self.base+1]
                
            if self.array[self.i]%10000 < 1000:
                par2 = self.array[self.array[self.i+2] : self.array[self.i+2]+1]
            elif self.array[self.i]%10000 < 2000:
                par2 = [self.array[self.i+2]]
            else:
                par2 = self.array[self.array[self.i+2] + self.base : self.array[self.i+2] + self.base + 1]

            if self.array[self.i]%100000 < 10000:
                par3 = self.array[self.array[self.i+3] : self.array[self.i+3]+1]
            else:
                par3 = self.array[self.array[self.i+3] + self.base:self.array[self.i+3] + self.base + 1]


            if self.array[self.i]%100 == 1:
                par3[0] = par1[0] + par2[0]
                self.i+=4
            elif self.array[self.i]%100 == 2:
                par3[0] = par1[0] * par2[0]
                self.i+=4
            elif self.array[self.i]%100 == 5: #jump-if-true
                if par1[0] != 0:
                    self.i=par2[0]
                else:
                    self.i+=3
            elif self.array[self.i]%100 == 6: #jump-if-false
                if par1[0] == 0:
                    self.i=par2[0]
                else:
                    self.i+=3
            elif self.array[self.i]%100 == 7: #less than
                if par1[0]<par2[0]:
                    par3[0]=1
                else:
                    par3[0]=0
                self.i+=4
            elif self.array[self.i]%100 == 8: #equals
                if par1[0] == par2[0]:
                    par3[0]=1
                else:
                    par3[0]=0           
                self.i+=4
            elif self.array[self.i]%100 == 9: #adjusts the relative self.base
                self.base += par1[0]
                self.i+=2
            elif self.array[self.i]%100 == 3:
                par1[0] = self.map[self.y][self.x]
                self.i+=2
            elif self.array[self.i]%100 == 4:
                #print(par1[0])
                which_output+=1
                if which_output % 2 == 1:
                    self.map[self.y][self.x] = par1[0]
                    self.painted.add((self.x,self.y))
                else:
                    self.turn(par1[0])
                self.i+=2
            elif self.array[self.i]%100 == 99:
                return self.array[0]
            else:
                print("Sth went wrong!", self.array[self.i]%100)
                return 0


if __name__ == '__main__':
    t1 = robot()
    t1.run_algorithm()
    print("Task 1:", len(t1.painted))

    t2 = robot(1)
    t2.run_algorithm()
    print("Task 1:", len(t2.painted))

    for i in range(t2.map.shape[0]):
        for j in range(t2.map.shape[1]):
            if t2.map[i][j] == 0:
                print('.', end='')
            else:
                print('#', end='')
        print('')



