extends Node
class_name GamePersistentData

var records : Array[float] = []

func add_time(new_time : float):
	records.append(new_time)
	
	if records.size() > 9:
		records.pop_front()
