extends Node2D
class_name vulcan_weapon

signal weapon_fired(bullet, location, direction)
@export var Bullet: PackedScene 
@onready var end_of_gun = $EndOfGun
@onready var gun_direction = $Gun_direction
@onready var enemy = null

func _physics_process(delta):
	if enemy !=null:
		var v = enemy.global_position - global_position
		var angle= v.angle()
		var r = global_rotation
		global_rotation = lerp_angle(r,angle,1.0)
	else:
		var mouse_position=get_global_mouse_position()
		look_at(mouse_position)


func vulcan_shoot():
		$AudioStreamPlayer.play()
		for x in 10:
			var bullet_instance = Bullet.instantiate()
			var direction= (gun_direction.global_position - end_of_gun.global_position).normalized()
			GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
			await get_tree().create_timer(0.1).timeout


func _on_area_2d_area_entered(area):
	if area.is_in_group("Rocket"):
		enemy = area


func _on_area_2d_area_exited(area):
	enemy and area==enemy
	enemy=null
