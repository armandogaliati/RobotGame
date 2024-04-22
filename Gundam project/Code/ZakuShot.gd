extends State
signal weapon_fired(bullet, location, direction)

@export var Bullet:PackedScene
var can_transition :bool = false
@onready var gun_direction=$"../../WeaponManager/bullet_spawner/Gun_direction"
@onready var end_of_gun=$"../../WeaponManager/bullet_spawner/EndOfGun"
@onready var audio=$AudioStreamPlayer2D
@onready var shot_timer=$Timer
var burst_amount_initial=10
var burst_amount=burst_amount_initial

func enter():
	super.enter()
	animation_player.play("zaku_gun_shoot")
	audio.play()
	shoot()
	await animation_player.animation_finished
	can_transition=true

func transition():
	if can_transition:
		can_transition=false
		get_parent().change_state("Dash")
		
func shoot():
	for x in 10:
		var bullet_instance = Bullet.instantiate()
		var direction= (gun_direction.global_position - end_of_gun.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
		await get_tree().create_timer(0.1).timeout
