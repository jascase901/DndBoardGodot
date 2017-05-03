extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state

var is_held = false
func _ready():
	game_state = get_node("../../Node").game_state
	set_process_input(true)
	set_process(true)
	
func _input(event):
	#is_held=true
	if event.type == InputEvent.MOUSE_BUTTON and not event.pressed and event.button_index == BUTTON_LEFT:
		is_held = false
	
func _process(delta):
	var fig = game_state.getFigurine("1")
	set_pos(Vector2(fig.x, fig.y))
	if is_held:
		var mouse_pos = (get_viewport().get_mouse_pos())
		game_state.moveFigurine("1",mouse_pos.x, mouse_pos.y)
		#set_pos((get_viewport().get_mouse_pos()))
			
			
func _on_RigidBody2D_input_event(viewport, event, shape_idx): 
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == BUTTON_LEFT:
		is_held = true