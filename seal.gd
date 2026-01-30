extends Node2D


@export var speed = 1000
var motion: Vector2 = Vector2(0,0) # desired direction
var velocity: Vector2 = Vector2(0,0)
var points = []
var radii = []
var arm_offsets = []
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
	
	var left_arm_offset = $Body.position - $LeftArm.position
	var right_arm_offset = $Body.position - $RightArm.position
	arm_offsets.append(left_arm_offset)
	arm_offsets.append(right_arm_offset)

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
		
func do_rotation(mot: Vector2):
	for i in range(segments.size()-1, 0, -1):
		#var foo: Sprite2D = segments[i]
		#foo.look_at()
		segments[i].look_at(segments[i-1].global_position)
	if mot.length() > 0.0001:
		segments[0].look_at(segments[0].global_position + mot)

func update_arms():
	#var foo = Vector2(1,2)
	#foo.rotated()
	$LeftArm.position = $Body.position + arm_offsets[0].rotated($Body.rotation)
	$RightArm.position = $Body.position + arm_offsets[1].rotated($Body.rotation)

	$LeftArm.rotation = lerp_angle($LeftArm.rotation, $Head.rotation, 0.2)
	$RightArm.rotation = lerp_angle($RightArm.rotation, $Head.rotation, 0.2)

# How do I get this to feel good?
	# Dashing
	# Gravity?
	
func finalize_position():
	var old_pos = Vector2(self.global_position)
	var new_pos = Vector2($Head.global_position)
	var diff = new_pos - old_pos
	##var head_pos = Vector2(segments[0].position)
	##var old_pos = Vector2(self.position)
	##var new_pos = head_pos
	##var diff = new_pos - old_pos
	for i in range(points.size()):
		points[i] -= diff
		segments[i].position = points[i]
	
	self.position += diff
		
	#self.position = new_pos
	#$Head.position = Vector2(0,0)
	
func _process(delta: float) -> void:
	var x = (int)(Input.is_key_pressed(KEY_D)) - (int)(Input.is_key_pressed(KEY_A))
	var y = (int)(Input.is_key_pressed(KEY_S)) - (int)(Input.is_key_pressed(KEY_W))
	motion = motion.lerp(Vector2(x, y).normalized(), 0.1)
	
	points[0] += speed * motion * delta
	
	enforce_distance()
	do_rotation(motion)
	update_arms()
	
	finalize_position()
		
#func _draw() -> void:
	#for point in points:
		#draw_circle(point, 1, Color.BLACK)
		
