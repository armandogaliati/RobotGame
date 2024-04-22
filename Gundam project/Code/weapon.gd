extends Node2D
class_name Weapon
#

signal weapon_fired(bullet, location, direction)
@export var Bullet: PackedScene 
@onready var end_of_gun = $"EndOfGun"
@onready var gun_direction = $"Gun_direction"
@onready var attack_cooldown = $"AttackCooldown"

func _physics_process(delta):
	var mouse_position=get_global_mouse_position()
	look_at(mouse_position)

func shoot():
	if attack_cooldown.is_stopped():
		$AudioStreamPlayer.play()
		var bullet_instance = Bullet.instantiate()
		var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
		
		attack_cooldown.start()
