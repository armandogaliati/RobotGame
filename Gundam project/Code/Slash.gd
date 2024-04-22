extends State
var can_transition :bool = false

func enter():
	super.enter()
	animation_player.play("slash")
	await animation_player.animation_finished

func transition():
	if owner.direction.length() > 100:
		get_parent().change_state("Follow")
		
func _on_area_2d_body_entered(body):
	if body.has_method("handle_hitmeleechar"):
		body.handle_hitmeleechar()

func exit():
	super.exit()
	animation_player.play("RESET")
