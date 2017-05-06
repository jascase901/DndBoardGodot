extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_text(get_node("../").id)
	# Called every time the node is added to the scene.
	# Initialization here
	pass
