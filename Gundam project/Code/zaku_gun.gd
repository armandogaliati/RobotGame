extends Node2D
class_name Zaku_weapon

signal weapon_fired(bullet, location, direction)
@export var Bullet: PackedScene 
@onready var end_of_gun = $"EndOfGun"
@onready var gun_direction = $"Gun_direction"
@onready var player = null
@onready var attack_cooldown=$main_timer
@onready var audio=$AudioStreamPlayer
var burst_amount_initial=10
var burst_amount=burst_amount_initial

func _physics_process(delta):
	if player !=null:
		var v = player.global_position - global_position
		var angle= v.angle()		
		var r = global_rotation
		global_rotation = lerp_angle(r,angle,0.1)
	else:
		pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
func _on_area_2d_body_exited(body):
	player and body==player
	player=null

func shoot():
	if attack_cooldown.is_stopped():
		for x in 10:
			var bullet_instance = Bullet.instantiate()
			var direction= (gun_direction.global_position - end_of_gun.global_position).normalized()
			GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
			await get_tree().create_timer(0.1).timeout
