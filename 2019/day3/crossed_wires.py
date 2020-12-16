import pandas as pd
import copy
import math

if __name__ == "__main__":
    df = pd.read_csv("input", sep=',', header=None);
    position = [0,0]
    first_wire = []
    crossing_point = []
    for command in df.iloc[0].dropna(): 
        for _ in range(0, int(command[1:])):
            if command[0] == 'U':
                position[1] += 1
            elif command[0] == 'L':
                position[0] -= 1
            elif command[0] == 'R':
                position[0] += 1
            else:
                position[1] -= 1
            first_wire.append(copy.copy(position))
    position = [0,0]
    dist=0
    for command in df.iloc[1].dropna():
        for _ in range(0, int(command[1:])):
            dist+=1
            if command[0] == 'U':
                position[1] += 1
            elif command[0] == 'L':
                position[0] -= 1
            elif command[0] == 'R':
                position[0] += 1
            else:
                position[1] -= 1
            for index, item in enumerate(first_wire): 
                if position == item:
                    crossing_point.append(copy.copy(position) + [index+1+dist])
                    break;

    min_distance = math.inf
    min_wire_distance = math.inf
    for point in crossing_point:
        distance = abs(point[0])+abs(point[1])
        if distance < min_distance:
            min_distance = distance
        if point[2] < min_wire_distance:
            min_wire_distance = point[2]


print("Task 1 result:", min_distance)
print("Task 2 result:", min_wire_distance)
