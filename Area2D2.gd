extends AABOX

onready var result : test = get_parent().get_node("Node2D")

func _ready():
	testCollision()


func testCollision():
	var a = $"../Area2D" as AABOX
	var ray = $RayCast2D
	
	var sweep : Sweep = a.SweepAABB(self, ray.cast_to)
	var sweep2 : Sweep = self.SweepAABB(a, -ray.cast_to)
	if sweep != null:
		print("sweep " + str(sweep.hit.time) + "  " + str(sweep.pos))
		result.position = sweep.pos
	else:
		print("not found")	

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
	
	
