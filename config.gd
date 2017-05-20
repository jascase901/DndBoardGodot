extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#This file writes my config
func _ready():
	var config = ConfigFile.new()
	if not config.has_section_key("networking", "serverip"):
		config.set_value("networking", "serverip", "SECRET")
	print(config.save("res://settings.cfg"))
	# Called every time the node is added to the scene.
	# Initialization here
	pass
