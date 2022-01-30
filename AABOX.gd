extends Area2D
class_name AABOX

#https://noonat.github.io/intersect/
#https://github.com/fuwwyUwU/drillGame/blob/inf-world-gen/Collisions/AABB.cs

const EPSILON : float = 1.401298e-45

func pos() -> Vector2:
	return position

func half() -> Vector2:
	var rec : RectangleShape2D = $CollisionShape2D.shape
	return rec.extents

func shape() -> RectangleShape2D:
	return $CollisionShape2D.shape

func IntersectPoint(point):
	pass

	
func IntersectSegment(pos: Vector2, delta: Vector2, paddingX: float, paddingY: float) -> Hit:
	var scaleX : float = 1.0 / delta.x
	var scaleY : float = 1.0 / delta.y
	
	var signX : float = sign(scaleX)
	var signY : float = sign(scaleY)
	
	var nearTimeX : float = (pos().x - signX * (half().x + paddingX) - pos.x) * scaleX 
	var nearTimeY : float = (pos().y - signY * (half().y + paddingY) - pos.y) * scaleY
	var farTimeX : float = (pos().x + signX * (half().x + paddingX) - pos.x) * scaleX 
	var farTimeY : float = (pos().y + signY * (half().y + paddingY) - pos.y) * scaleY
	
	if nearTimeX > farTimeY || nearTimeY > farTimeX:
		return null
		
	var nearTime = nearTimeX if nearTimeX > nearTimeY else nearTimeY
	var farTime = farTimeX if farTimeX < farTimeY else farTimeY
	
	if nearTimeX >= 1 || farTime <= 0:
		return null
		
	var hit = Hit.new()
	hit.time = clamp(nearTime, 0, 1)
	
	if nearTimeX > nearTimeY:
		hit.normal.x = -signX
	else:
		hit.normal.y = -signY
		
	hit.delta.x = (1.0 - hit.time) * -delta.x
	hit.delta.y = (1.0 - hit.time) * -delta.y
	hit.pos.x = pos().x + delta.x * hit.time
	hit.pos.y = pos().y + delta.y * hit.time
	return hit
	
	
func IntersectAABB(box: AABOX) -> Hit:
	var dx: float = box.pos().x - pos().y
	var px: float = (box.half().x + half().x) - abs(dx)
	
	if px <= 0:
		return null
		
	var dy: float = box.pos().y - pos().y
	var py: float = (box.half().y + half().y) - abs(dy)
	
	if py <= 0:
		return null
	
	var hit: Hit = Hit.new()
	if px < py:
		var sx: float = sign(dx)
		hit.delta.x = px * sx
		hit.normal.x = sx
		hit.pos.x = pos().x + (half().x * sx)
		hit.pos.y = box.pos().y
	else:
		var sy: float = sign(dy)
		hit.delta.y = py * sy
		hit.normal.y = sy
		hit.pos.x = box.pos().x
		hit.pos.y = pos().y + (half().y * sy)
		
	return hit
	
func SweepAABB(box: AABOX, delta: Vector2) -> Sweep:
	var sweep: Sweep = Sweep.new()
	
	if delta.x == 0 && delta.y == 0:
		sweep.pos.x = box.pos().x
		sweep.pos.y = box.pos().y
		sweep.hit = IntersectAABB(box)
		sweep.time = 0 if sweep.hit != null else 1
		return sweep
	
	sweep.hit = IntersectSegment(box.pos(), delta, box.half().x, box.half().y)
	if sweep.hit != null:
		sweep.time = clamp(sweep.hit.time - EPSILON, 0, 1)
		sweep.pos.x = box.pos().x + delta.x * sweep.time
		sweep.pos.y = box.pos().y + delta.y * sweep.time
		var direction: Vector2 = Vector2(delta.x, delta.y)
		direction = direction.normalized()
		sweep.hit.pos.x = clamp(sweep.hit.pos.x + direction.x * box.half().x, pos().x - half().x, pos().x + half().x)
		sweep.hit.pos.y = clamp(sweep.hit.pos.y + direction.y * box.half().y, pos().y - half().y, pos().y + half().y)
	else:
		sweep.pos.x = box.pos().x + delta.x
		sweep.pos.y = box.pos().y + delta.y
		sweep.time = 1
	return sweep
