extends AnimatedSprite2D
func play_idle_animation():
	self.play("idle")
func play_left_animation():
	self.play("walk_left")
func play_right_animation():
	self.play("walk_right")
