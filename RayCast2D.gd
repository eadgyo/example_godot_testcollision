extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var parent = get_node("..")
	
	draw_line(position, position + cast_to, Color.red)
	var normal : Vector2 = Vector2(-cast_to.y, cast_to.x)
	normal = normal.normalized()
	var l = 20 / cast_to.length()
	var a = position + cast_to * (1 - l) + 20 * normal
	var b = position + cast_to * (1 - l) - 20 * normal
	draw_line(position + cast_to, a, Color.red)
	draw_line(position + cast_to, b, Color.red)
