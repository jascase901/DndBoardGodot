extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var client
var label
var anim

func _ready():
	client = get_node("../Client")	
	anim = get_node("Display")
	label = get_node("Display/Label")
	client.connect("not_connected_signal",self,"display_text")	
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func display_text(data):
	label.set_text("Not Connected :"+data[0])
	anim.play("New Anim")
	

