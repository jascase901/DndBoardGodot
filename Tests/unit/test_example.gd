extends "res://addons/gut/test.gd"

var GameState = load("res://Players/GameState.gd")
var Decoder = load("res://Players/Decoder.gd")
var game_state
var decoder

func setup():	
	game_state = GameState.new()
	decoder = Decoder.new()

	
	decoder.connect("figurine_pos", game_state, "addFigurine")
	decoder.connect("player_connect", game_state, "moveFigurine")
	decoder.connect("player_disconnect", game_state, "removeFigurine")
	#load state
	#load decoder
	
	#connect add_player
	#connect remove_player
	#connect move_figurine
	gut.p("ran setup", 2)

func teardown():
	gut.p("ran teardown", 2)

func prerun_setup():
	gut.p("ran run setup", 2)

func postrun_teardown():
	gut.p("ran run teardown", 2)

func test_add_figurine():
	decoder.decode([1,"test", 0, 0])
	#game_state.addFigurine("test", 0, 0)

	assert_eq(game_state.getFigurine("test").name, "test", "game_state should have 'test'")
	
func test_not_has_figurine():
	var fig = game_state.getFigurine("test")
	assert_eq(fig, null, "game state should not have 'test'")

func test_remove_figurine():
	var fig = game_state.addFigurine("test",0,0)
	game_state.removeFigurine("test")
	fig = game_state.getFigurine("test")
	assert_eq(fig, null, "game state should not have 'test'")
	
func test_remove_nonexistant_figurine():
	game_state.removeFigurine("test")
	var fig = game_state.getFigurine("test")
	assert_eq(fig, null, "game state should not have 'test'")
	
		
	


