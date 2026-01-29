extends Node2D



var points = [
]
var radii = [
	
]
@onready var segments = [
	$Head,
	$Neck,
	$Body,
	$Tail1,
	$Tail2,
	$Tail3,
]

func _ready() -> void:
	for i in range(segments.size()-1):
		var seg: Node2D = segments[i]
		var next: Node2D = segments[i+1]
		points.append(seg.position)
		var diff = next.position - seg.position
		radii.append(diff.length())
		
	points.append(segments[segments.size()-1].position)

func enforce_distance(reverse=0):
	var inc = 1
	if reverse:
		inc = -1
	
	var start = points.size() * reverse
	var stop = (points.size() * (1 - reverse)) - inc
	for i in range(start, stop):
		var pt = points[i]
		var pt2 = points[i+inc]
		var diff = pt2 - pt
		diff = diff.normalized() * radii[i]
		var new_pt2 = pt + diff
		points[i+inc] = new_pt2
	
	for i in range(points.size()):
		segments[i].position = points[i]
		
func do_rotation():
	for i in range(segments.size()-1, 0, -1):
		segments[i].look_at(segments[i-1].position)
	
func _process(delta: float) -> void:
	var speed = 200
	if Input.is_key_pressed(KEY_A):
		points[0].x -= speed * delta
	if Input.is_key_pressed(KEY_D):
		points[0].x += speed * delta
		
	if Input.is_key_pressed(KEY_W):
		points[0].y -= speed * delta
	if Input.is_key_pressed(KEY_S):
		points[0].y += speed * delta
		
	enforce_distance()
	do_rotation()
	
	queue_redraw()
		
func _draw() -> void:
	for point in points:
		draw_circle(point, 1, Color.BLACK)
		
