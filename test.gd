extends Node2D
class_name test

var center = Vector2(0,0)
var size = Vector2(50, 50)

func _draw():
	var points = PoolVector2Array()
	points.push_back(Vector2(-size.x, size.y)/2)
	points.push_back(Vector2(size.x, size.y)/2)
	points.push_back(Vector2(size.x, -size.y)/2)
	points.push_back(Vector2(-size.x, -size.y)/2)
	
	draw_line(points[0], points[1], Color.green)
	draw_line(points[1], points[2], Color.green)
	draw_line(points[2], points[3], Color.green)
	draw_line(points[3], points[0], Color.green)
