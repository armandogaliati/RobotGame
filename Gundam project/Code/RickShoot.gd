extends State
signal weapon_fired(bullet, location, direction)

@export var Bullet:PackedScene
var can_transition :bool = false
@onready var gun_direction=$"../../WeaponManager/bullet_spawner/Gun_direction"
@onready var end_of_gun=$"../../WeaponManager/bullet_spawner/EndOfGun"
@onready var audio=$AudioStreamPlayer2D

func enter():
	super.enter()
	await get_tree().create_timer(0.5).timeout
	animation_player.play("rick_gun_shoot")
	shoot()
	await animation_player.animation_finished
	await get_tree().create_timer(2).timeout
	can_transition=true

func transition():
	if can_transition:
		can_transition=false
		get_parent().change_state("Follow")
		
func shoot():
	await get_tree().create_timer(0.1).timeout
	audio.play()
	var bullet_instance = Bullet.instantiate()
	var direction= (gun_direction.global_position - end_of_gun.global_position).normalized()
	GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
