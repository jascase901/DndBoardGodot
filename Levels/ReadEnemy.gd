extends Node

var GameState = load("res://Players/GameState.gd")
var Decoder = load("res://Players/Decoder.gd")


# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var game_state = GameState.new()
var game_statep = GameState.new()
var decoder = Decoder.new()
var client
export var is_show_id = false
	
func _ready():
	client = get_node("Client")
	client.connect("data_recieved_signal",self,"Client")
	
	decoder.connect("figurine_pos", game_state, "addFigurine")
	decoder.connect("player_connect", game_state, "moveFigurine")
	decoder.connect("player_disconnect", game_state, "removeFigurine")

		
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization her

func blit_enemy(enemy):
	if  has_node(enemy.name):
		return
	
	var s = Label.new()
	s.set_name(enemy.name)
	s.set_pos(Vector2(enemy.x, enemy.y))
	if is_show_id:
		s.set_text(enemy.name)

	#remove child if already in scene
	
	add_child(s)
	
func blit_enemies():
	for enemy in game_state.getFigurines():
		blit_enemy(enemy);
		var prev = game_statep.getFigurine(enemy.name)
		var is_enemy_moved = (prev != null 
			and
			( 
			(prev.x != enemy.x)
			or
			(prev.y != enemy.y)))
			
		if is_enemy_moved:
			client.write([1,enemy.name, int(enemy.x), int(enemy.y)])
		game_statep.addFigurine(enemy.name, int(enemy.x), int(enemy.y))

func _process(delta):
	blit_enemies()
	
func Client(data):
	decoder.decode(data)
	