extends Node2D
class_name vulcan_weapon

signal weapon_fired(bullet, location, direction)
@export var Bullet: PackedScene 
@onready var end_of_gun = $EndOfGun
@onready var gun_direction = $Gun_direction
@onready var enemy = null
@onready var attack_cooldown=$vulcan_timer
@onready var shot_timer=$vulcan_shot_timer
var burst_amount_initial=15
var burst_amount=burst_amount_initial

func _physics_process(delta):
	if enemy !=null:
		var v = enemy.global_position - global_position
		var angle= v.angle()
		var r = global_rotation
		global_rotation = lerp_angle(r,angle,0.1)
	else:
		pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		enemy = body
func _on_area_2d_body_exited(body):
	enemy and body==enemy
	enemy=null
#
func vulcan_shoot():
	if attack_cooldown.is_stopped():
		if shot_timer.is_stopped():
			var bullet_instance = Bullet.instantiate()
			var direction= (gun_direction.global_position - end_of_gun.global_position).normalized()
			GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
			if burst_amount==burst_amount_initial:
				$AudioStreamPlayer.play()
			burst_amount-=1
			shot_timer.start(0.1)
			print (burst_amount)
			if burst_amount > 0:
				pass
			else:
				attack_cooldown.start()
				burst_amount=burst_amount_initial

