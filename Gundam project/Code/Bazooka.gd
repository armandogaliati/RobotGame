extends State
@export var Bullet:PackedScene
var can_transition :bool = false
@onready var gun_direction=$"../../WeaponManager/bullet_spawner/Gun_direction"
@onready var end_of_gun=$"../../WeaponManager/bullet_spawner/EndOfGun"
@onready var audio=$AudioStreamPlayer2D

func enter():
	super.enter()
	animation_player.play("bazooka_shot")
	
	await animation_player.animation_finished
	shoot()
	can_transition=true

func transition():
	if can_transition:
		can_transition=false
		get_parent().change_state("Dash")
		
func shoot():
	audio.play()
	var bullet_instance = Bullet.instantiate()
	var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
	GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
	
