var figurines = {}
var Figurine = load("res://Players/Figurine.gd")
func _init():
  self.figurines = {} 

func getFigurine(id):
	if self.figurines.has(id):
	  return self.figurines[id]
	return null

func getFigurines():
  return self.figurines.values()

func addFigurine(id, x, y):
	if self.figurines.has(id):
		moveFigurine(id, x, y)
	else:
	  self.figurines[id] = Figurine.new(id, x, y)

func moveFigurine(id, x, y):
	self.figurines[id].x = x
	self.figurines[id].y = y
	
func removeFigurine(id):
	self.figurines.erase(id)
