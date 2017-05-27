extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state
export var id="1"

var is_held = false
var selected_id = null
func _ready():
	game_state = get_node("../../../Node").game_state
	game_state.addFigurine(id, get_pos().x, get_pos().y);
	set_process(true)
	set_fixed_process(true)

		
func _fixed_process(delta):
	var fig = game_state.getFigurine(id)
	if fig == null:
		print("not in game state fig_name:", id)
		return
	set_pos(Vector2(fig.x, fig.y))

	var space_state = get_world_2d().get_direct_space_state()
	var mouse_pos = (get_viewport().get_mouse_pos())
	var results = [space_state.intersect_ray(mouse_pos, Vector2(2,0))
	]
	for result in results:
		if (not result.empty() and not is_held):
			if result.collider extends KinematicBody2D:
				selected_id = result.collider_id
				print(selected_id)

	if is_held and (self.get_instance_ID() == selected_id):
		set_pos(Vector2(int(mouse_pos.x), int(mouse_pos.y)))

func _on_DragableRB_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == BUTTON_LEFT:
		is_held = true
	if event.type == InputEvent.MOUSE_BUTTON and not event.pressed and event.button_index == BUTTON_LEFT:
		var fig = game_state.getFigurine(id)
		if is_held  and fig != null and self.get_instance_ID() == selected_id:
			var mouse_pos = (get_viewport().get_mouse_pos())
			game_state.moveFigurine(id,int(mouse_pos.x), int(mouse_pos.y))
		is_held = false