import numpy as np
import copy
import math

def filter_yfloats(line):
    if line[1] % 1 == 0:
        return True
    return False

def angle(p1, p2):
    ang1 = np.arctan2(*p1[::-1])
    ang2 = np.arctan2(*p2[::-1])
    return np.rad2deg((ang2 - ang1) % (2 * np.pi))


class line:
    def __init__(self,x1,y1,x2,y2):
        self.x = -1
        if x1 == x2:
            self.x = x1
            self.a=self.b=0
        else:
            self.a,self.b = np.polyfit([x1,x2], [y1,y2], 1)
            self.poly = np.poly1d([self.a,self.b])

    def get_every_point_on_line(self, map):
        points = []
        for x in range(map.shape[0]):
            for y in range(map.shape[1]):
                if self.x != -1 and x == self.x and map[y][x] == '#':
                    points.append([x,y])
                elif self.x == -1 and abs(self.a * x + self.b - y) < 0.01 and map[y][x] == '#':
                    points.append([x,y])        
        return points

if __name__ == '__main__':
    with open("input") as file:
        map = [list(line.rstrip()) for line in file]
        map = np.array(map)
        distancemap = np.zeros(map.shape)
        angle_map = np.array(([[float("NaN") for i in range(map.shape[1])] for i in range(map.shape[0])]))
        for x in range(map.shape[0]):
            for y in range(map.shape[1]): #for every element in map
                if map[y][x] == '#':
                    visibility_map = copy.copy(map)

                    for vx in range(map.shape[0]):
                        for vy in range(map.shape[1]): #for every element in visibility map:
                            if visibility_map[vy][vx] == '#':
                                if x==vx and y == vy:
                                    continue
                                l  = line(x,y,vx,vy)
                                linear = l.get_every_point_on_line(visibility_map)
                                linear.remove([x,y])
                                linear.sort(key=lambda tup: abs(tup[0]-x) + abs(tup[1]-y))
                                                           
                                for point in linear:
                                    if np.sign(point[0] - x) !=  np.sign(linear[0][0] - x) or\
                                        np.sign(point[1] - y) !=  np.sign(linear[0][1] - y):
                                        linear.remove(point)
                                        break
                                
                                del(linear[0])

                                for point in linear:
                                    visibility_map[point[1]][point[0]]='x'
                    cnt = 0
                    for vx in range(map.shape[0]):
                        for vy in range(map.shape[1]): #for every element in visibility map:
                            if visibility_map[vy][vx]=='#':
                                cnt+=1
                    distancemap[y][x] = cnt - 1
        print("Task one:", distancemap.max())

        ([y],[x]) = np.where(distancemap.max() == distancemap)

        for vx in range(map.shape[0]):
            for vy in range(map.shape[1]): #for every element in map
                if map[vy][vx]=='#':
                    #if x==vx and y == vy:
                    #    continue
                    angle_map[vy][vx]=angle([0,-1],[vx-x,vy-y])

        angle_map[y][x]=('NaN')

        values = set()
        for vx in range(map.shape[0]):
            for vy in range(map.shape[1]): #for every element in map:
                if not math.isnan(angle_map[vy][vx]):
                    values.add(angle_map[vy][vx])
        values = list(values)
        values.sort()

        cnt=1
        index = 0
        while(1):
            found = []
            min_dist = math.inf
            curr_val = values[index]
            for vx in range(map.shape[0]):
                for vy in range(map.shape[1]):
                    if angle_map[vy][vx] == curr_val:
                        found.append([vx,vy])

            for point in found:
                dist = abs(x-point[0])+abs(y-point[1])
                if dist < min_dist:
                    min_dist = dist
                    min_point = point
            
            if min_dist != math.inf:
                angle_map[min_point[1]][min_point[0]] = math.nan
                cnt+=1

            if(index < len(values)-1):
                index += 1
            else:
                index = 0 

            if cnt == 201:
                print("Task one 1:", min_point[0]*100 + min_point[1])
                break





        
