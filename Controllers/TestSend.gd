extends "res://Controllers/net_constants.gd"
var a;
func _ready():
	a = get_node("Client")
	print (a.get_name())
	#a.write("test")
	
	get_node("TestButton").connect("pressed",self,"my_function")
	get_node("Client").connect("data_recieved_signal",self,"Client")
	get_node("Client 2").connect("data_recieved_signal",self,"Client2")
	pass
func my_function():
	a.write("test")

func Client(data):
	print("Client1", data)
func Client2(data):
	print("Client2", data)
	

