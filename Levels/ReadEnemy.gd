extends Node

var GameState = load("res://Players/GameState.gd")
var Decoder = load("res://Players/Decoder.gd")


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state = GameState.new()
var decoder = Decoder.new()
var client
	
func _ready():
	client = get_node("Client")
	client.connect("data_recieved_signal",self,"Client")
	
	decoder.connect("figurine_pos", game_state, "addFigurine")
	decoder.connect("player_connect", game_state, "moveFigurine")
	decoder.connect("player_disconnect", game_state, "removeFigurine")

	game_state.addFigurine("1", 50, 60)
		
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization her

func blit_enemy(enemy):
	var s = Label.new()
	s.set_name(enemy.name)
	s.set_text(enemy.name)
	s.set_pos(Vector2(enemy.x, enemy.y))
	
	#remove child if already in scene
	if  has_node(enemy.name):
		remove_child(get_node(enemy.name))
	add_child(s)
	
func blit_enemies():
	for enemy in game_state.getFigurines():
		blit_enemy(enemy);
		client.write([1,enemy.name, enemy.x, enemy.y])

func _process(delta):
	blit_enemies()
	
func Client(data):
	decoder.decode(data)
	