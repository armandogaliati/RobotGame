extends Node2D

const dash_delay = 0.5
@onready var duration_timer=$DurationTimer
@onready var ghost_timer=$GhostTimer
@export var ghost_scene=preload("res://Gundam project/Scenes/ghost_scene.tscn")
var can_dash=true
var sprite
func start_dash(sprite, duration):
	self.sprite = sprite
	duration_timer.wait_time=duration
	duration_timer.start()
	ghost_timer.start()
	instance_ghost()

func instance_ghost():
	var ghost: Sprite2D = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	var current_frame_index = sprite.frame
	var current_animation_index=sprite.animation
	var frame = sprite.sprite_frames.get_frame_texture(current_animation_index, current_frame_index)
	ghost.texture = frame
	ghost.global_position=global_position


func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	ghost_timer.stop()
	can_dash=false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true
	

func _on_duration_timer_timeout():
	end_dash()


func _on_ghost_timer_timeout():
	instance_ghost()
