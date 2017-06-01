extends Node2D

onready var SELECTED_ID = null


func get_selected(mouse_pos):
	if SELECTED_ID != null:
		return SELECTED_ID
		
	var space_state = get_world_2d().get_direct_space_state()
#	var results = [space_state.intersect_ray(mouse_pos, Vector2(2,0)),
#	space_state.intersect_ray(mouse_pos, Vector2(-2,0)),
#	space_state.intersect_ray(mouse_pos, Vector2(0,2)),
#	space_state.intersect_ray(mouse_pos, Vector2(0,-2))
#	]
#	
#	var min_dist=1000;
#	var min_result = null
#	for result in results:
#		if result.empty():
#			continue
#		var dist = mouse_pos.distance_to(result.position) 
#		if dist < min_dist:
#			min_dist = dist
#			min_result = result
			
	var min_result = space_state.intersect_ray(mouse_pos, Vector2(2,0))
	if min_result != null && not min_result.empty():
		if min_result.collider extends KinematicBody2D:
			SELECTED_ID = min_result.collider_id
				
	return SELECTED_ID;
