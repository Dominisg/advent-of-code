import pandas as pd

class Node:
    def __init__(self, value):
        self.parent = None
        self.value = value
        self.childs = []

    def __str__(self):
        if self.parent:
            return f"Value:{self.value} Parent:{self.parent.value}" 
        else:
            return f"Value:{self.value} Parent:None" 


def calculate_orbits(nodes):
    orbits_sum = 0
    for node in nodes:
        orbits_sum += sum_childs(node)
    return orbits_sum


def sum_childs(node):
    csum = 0
    for child in node.childs:
        csum += sum_childs(child)
    csum += len(node.childs)
    return csum

def orbitral_distance(a,b):
    if a.parent == None or b.parent == None:
        return
    a = a.parent
    b = b.parent

    par_a = a.parent
    par_b = b.parent

    a_dist = 1
    b_dist = 1

    while par_b:
        while par_a:
            if par_a  == par_b:
                return a_dist+b_dist
            par_a = par_a.parent
            a_dist+=1
        par_b = par_b.parent
        b_dist += 1
        a_dist = 1
        par_a = a.parent

if __name__ == '__main__':
    df = pd.read_csv("input", sep=')', header=None)
    #df = pd.read_csv("test_input", sep=')', header=None)
    nodes = []
    root = None
    for i,row in df.iterrows(): 
        first_node = second_node = None
        for node in nodes:
            if(node.value == row[0]):
                first_node = node
                break
        for node in nodes:
            if(node.value == row[1]):
                second_node = node
                break
        
        if(first_node == None):
            first_node = Node(row[0])
            nodes.append(first_node)
            if row[0] == "COM":
                root = first_node
        
        if(second_node == None):
            second_node = Node(row[1])
            nodes.append(second_node)
            if row[1] == "YOU":
                you = second_node
            elif row[1] == "SAN":
                santa = second_node

        first_node.childs.append(second_node)
        second_node.parent = first_node

    print("Task 1:",calculate_orbits(nodes))
    print("Task 2:",orbitral_distance(you,santa))

        
