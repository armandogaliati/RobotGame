extends Node2D

@onready var end_of_gun =$EndOfGun
@onready var gun_direction =$Gun_direction
@onready var player = null


func _physics_process(delta):
	if player !=null:
		var v = player.global_position - global_position
		var angle= v.angle()
		var r = global_rotation
		global_rotation = lerp_angle(r,angle,1.0)
	else:
		pass


func _on_player_detection_body_entered(body):
	if body.is_in_group("player"):
		player = body
