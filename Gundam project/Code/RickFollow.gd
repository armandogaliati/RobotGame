extends State
@onready var anim=$"../../AnimatedSprite2D"

func enter():
	super.enter()
	owner.set_physics_process(true)


func exit():
	super.exit()
	owner.set_physics_process(false)


func transition():
	var distance = owner.direction.length()
	
	if distance < 450:
		get_parent().change_state("Shoot")
