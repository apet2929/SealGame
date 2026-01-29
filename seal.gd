extends Node2D


var points = [
	Vector2(Vector2.ZERO)
]

func enforce_distance(reverse=0):
	var inc = 1
	if reverse:
		inc = -1
		
	var max_dist = 5
	var foo = Vector2.ZERO
	foo.normalized()
	
	# if not reversed: points[1] gets restricted by points[0]
	var start = points.size() * reverse
	var stop = (points.size() * (1 - reverse)) - inc
	print(points.size())
	print(start)
	
	print(stop)
	for i in range(start, stop):
		var pt = points[i]
		var pt2 = points[i+inc]
		var diff = pt2 - pt
		diff = diff.normalized() * max_dist
		var new_pt2 = pt + diff
		points[i+inc] = new_pt2

func _init() -> void:
	var pt = points[0]
	for i in range(5):
		pt = Vector2(pt) + Vector2(-5, 0)
		points.append(pt)
		
func _process(delta: float) -> void:
	var speed = 20
	if Input.is_key_pressed(KEY_A):
		points[0].x -= speed * delta
	if Input.is_key_pressed(KEY_D):
		points[0].x += speed * delta
		
	if Input.is_key_pressed(KEY_W):
		points[0].y -= speed * delta
	if Input.is_key_pressed(KEY_S):
		points[0].y += speed * delta
		
	enforce_distance()
	
	queue_redraw()
		
func _draw() -> void:
	for point in points:
		draw_circle(point, 1, Color.BLACK)
		
