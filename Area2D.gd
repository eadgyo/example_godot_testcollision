extends AABOX


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	var center = self.pos()
	var size = self.half()
	var points = PoolVector2Array()
	points.push_back(Vector2(-size.x, size.y))
	points.push_back(Vector2(size.x, size.y))
	points.push_back(Vector2(size.x, -size.y))
	points.push_back(Vector2(-size.x, -size.y))
	
	draw_line(points[0], points[1], Color.black)
	draw_line(points[1], points[2], Color.black)
	draw_line(points[2], points[3], Color.black)
	draw_line(points[3], points[0], Color.black)
	
	
func test():
	print("hello")
