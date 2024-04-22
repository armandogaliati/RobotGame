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
	
	if distance < 120:
		get_parent().change_state("Slash")
	elif distance < 500:
		
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("ZakuShot")
			1:
				get_parent().change_state("Bazooka")
