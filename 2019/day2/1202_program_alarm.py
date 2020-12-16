import pandas as pd
import numpy as np

def run_algorithm(noun, verb):
	array = pd.read_csv("input", sep=',', header = None).to_numpy()[0]	
	array[1]=noun
	array[2]=verb
	for i in range(0,array.size , 4): 
		if array[i] == 1:
            		array[array[i+3]] = array[array[i+1]] + array[array[i+2]]
		elif array[i] == 2:
			array[array[i+3]] = array[array[i+1]] * array[array[i+2]]
		elif array[i] == 99:
			return array[0]
			break
		else:
			print("Sth went wrong!")
			return 0

if __name__ == '__main__':
	res = run_algorithm(12,2)
	print("Task 1 result:",res)
	for i in range(0, 99):
		for j in range(0, 99):
			if run_algorithm(i,j) == 19690720:
				print("Task 2 result:", i*100 + j)	 
