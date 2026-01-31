extends Camera2D

@export var target: CharacterBody2D
@export var lerp_speed: float = 0.5
@export var dynamic_zoom: Vector2 = Vector2(0.5, 0.5)
@export var base_zoom: Vector2 = Vector2(1.0, 1.0)
func _process(delta: float) -> void:
	self.global_position = self.global_position.lerp(target.global_position, lerp_speed)
	self.zoom = base_zoom.lerp(dynamic_zoom, target.motion.length()/target.speed)
