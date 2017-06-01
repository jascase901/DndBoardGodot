extends KinematicBody2D
var shader = preload("res://highlight_material.tres")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state
export var id="1"

var is_held = false

func _ready():
	set_material(shader.duplicate())
	get_material().set_shader_param("enabled", false);

	game_state = get_node("../../../Node").game_state
	game_state.addFigurine(id, get_pos().x, get_pos().y);
	set_process(true)
	set_fixed_process(true)

func _fixed_process(delta):
	#var is_nothing_selected = SELECTED_SINGLETON.SELECTED_ID == null;
	var mouse_pos = (get_viewport().get_mouse_pos())

	var is_this_node_selected =( 
		self.get_instance_ID() == SELECTED_SINGLETON.get_selected(mouse_pos))
	
	if not is_this_node_selected:
		get_material().set_shader_param("enabled", false);	
		return;
	
	var fig = game_state.getFigurine(id)
	if fig == null:
		print("not in game state fig_name:", id)
		return
	set_pos(Vector2(fig.x, fig.y))


	if is_held:
		set_pos(Vector2(int(mouse_pos.x), int(mouse_pos.y)))
		get_material().set_shader_param("enabled", true);


func _on_DragableRB_input_event( viewport, event, shape_idx ):
	if event.is_action_pressed("MOUSE_BUTTON"):
		SELECTED_SINGLETON.SELECTED_ID=null
		is_held = true

	if event.is_action_released("MOUSE_BUTTON"):
		var fig = game_state.getFigurine(id)
		if is_held  and fig != null:
			var mouse_pos = (get_viewport().get_mouse_pos())
			game_state.moveFigurine(id,int(mouse_pos.x), int(mouse_pos.y))
			SELECTED_SINGLETON.SELECTED_ID=null
			is_held = false