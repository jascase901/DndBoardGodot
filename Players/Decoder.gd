extends "res://Controllers/net_constants.gd"

signal player_connect
signal player_disconnect
signal figurine_pos

func decode(data):
	var cmd_type = data[0]
	if cmd_type == PLAYER_CONNECT:
		emit_signal("player_connect")
	elif cmd_type == PLAYER_DISCONNECT:
		emit_signal("player_disconnect")
	elif cmd_type == FIGURINE_POS:
		emit_signal("figurine_pos", data[1], data[2], data[3])
    
  