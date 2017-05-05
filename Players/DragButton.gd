extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state
export var id="1"

var is_held = false
func _ready():
	game_state = get_node("../../Node").game_state
	game_state.addFigurine(id, get_pos().x, get_pos().y);
	set_process_input(true)
	set_process(true)
	
func _input(event):
	#is_held=true
	if event.type == InputEvent.MOUSE_BUTTON and not event.pressed and event.button_index == BUTTON_LEFT:
		var fig = game_state.getFigurine(id)
		if is_held and fig != null:
			var mouse_pos = (get_viewport().get_mouse_pos())
			game_state.moveFigurine(id,int(mouse_pos.x), int(mouse_pos.y))
		is_held = false
	
func _process(delta):
	var fig = game_state.getFigurine(id)
	if fig == null:
		print("not in game state fig_name:", id)
		return
	set_pos(Vector2(fig.x, fig.y))
	if is_held:
		pass



			
			
func _on_RigidBody2D_input_event(viewport, event, shape_idx): 
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == BUTTON_LEFT:
		is_held = true