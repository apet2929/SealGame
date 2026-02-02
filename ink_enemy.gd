extends RigidBody2D

@export var target: CharacterBody2D
@export var speed = 8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var bearing = (target.global_position-self.global_position).normalized()
	#var velocity = bearing * speed
	#move_and_collide(velocity)
	pass
