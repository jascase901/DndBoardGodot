extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enemies  = {}
class Enemy:
	var name
	var x
	var y
	func _init(name, x, y):
		self.name = name
		self .x = x
		self.y = y
	
func _ready():
	
	#s.set_pos(Enemy.x, Enemy.y)
	var enemy_list = [Enemy.new("1", 50, 60),
	Enemy.new("1", 50, 60),
	Enemy.new("2", 150, 60),
	Enemy.new("3", 250, 60),
	Enemy.new("4", 350, 60)]
	
	for enemy in enemy_list:
		enemies[enemy.name] = enemy
	
	add_enemies()

		
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	
func update_postions():
	for enemy in enemies.values():
		var ScreenEnemy = get_node(enemy.name)
		ScreenEnemy.set_pos(Vector2(enemy.x, enemy.y))

func add_enemy(enemy):
	var s = Label.new()
	s.set_name(enemy.name)
	s.set_text(enemy.name)
	s.set_pos(Vector2(enemy.x, enemy.y))
	s.show()
	add_child(s)
	
func add_enemies():
	for enemy in enemies.values():
		add_enemy(enemy);

	
func _process(delta):
	#update_postions()

	enemies["1"].x+=2;
