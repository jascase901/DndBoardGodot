extends Node2D
var GameState = load("res://Players/GameState.gd")
var Decoder = load("res://Players/Decoder.gd")
var Server

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state
var decoder
var server

func _ready():
	game_state = GameState.new()
	decoder = Decoder.new()
	server = get_node("../Server")
	server.connect("data_recieved_signal", decoder, "decode")
	
	decoder.connect("figurine_pos", game_state, "addFigurine")
	decoder.connect("player_connect", self, "sync")
	decoder.connect("player_disconnect", game_state, "removeFigurine")
	# Called every time the node is added to the scene.

func sync():
	for fig in game_state.getFigurines():
		server.BroadCastData(null, [1, fig.name, fig.x, fig.y])