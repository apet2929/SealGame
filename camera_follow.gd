extends Camera2D

@export var target: Node2D
@export var lerp_speed: float = 0.5
func _process(delta: float) -> void:
	self.global_position = self.global_position.lerp(target.global_position, lerp_speed)
