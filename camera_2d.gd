extends Camera2D

# https://youtu.be/dIEGn8uOIwg?si=mLZmteEqoxquPNX8
func _process(delta):
	var speed = 50
	if Input.is_key_pressed(KEY_A):
		self.position.x -= speed * delta
		
	if Input.is_key_pressed(KEY_D):
		self.position.x += speed * delta
		
