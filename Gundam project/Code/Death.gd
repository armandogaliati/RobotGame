extends State
 
func enter():
	super.enter()
	animation_player.play("char defeated")
	await animation_player.animation_finished
	
