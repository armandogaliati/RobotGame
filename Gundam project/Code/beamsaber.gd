extends Weapon

@onready var anim = $Area2D/AnimationPlayer

func _physics_process(delta):
	pass

func shoot():
	anim.play("swing")
	


func _on_area_2d_body_entered(body):
	if body.has_method("handle_hitmelee"):
		body.handle_hitmelee()
