extends CharacterBody2D
class_name Player

signal player_health_changed(new_health)


const move_speed=600
const dash_speed=2000
const dash_duration= 0.2


@onready var health_stat = $"Health"
@onready var weapon_manager = $"Weapon Manager"
@onready var sprite = $AnimatedSprite2D
@onready var vulcan = $"Headvulcan"
@onready var dash = $Dash
@onready var progress_bar= $GUI/Rows/TextureRect/HealthBar

var player_dead = false

var health = 1000:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			get_tree().change_scene_to_file("res://Gundam project/Scenes/GameOverScreen.tscn")


func _process(delta):
	if Input.is_action_pressed("vulcan_shoot"):
		vulcan.vulcan_shoot()


func _physics_process(delta):
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite, dash_duration)
	var movedirection = Input.get_vector("move_left","move_right","move_up","move_down")
	var speed = dash_speed if dash.is_dashing() else move_speed
	velocity=movedirection.normalized()*speed
	
	move_and_slide()
	if Input.is_action_pressed("move_left"):
		sprite.play_left_animation()
		
	elif Input.is_action_pressed("move_right"):
		sprite.play_right_animation()
	else:
		sprite.play_idle_animation()


func shoot(bullet_instance, location:Vector2, direction: Vector2):
	GlobalSignals.emit_signal("bullet_fired", bullet_instance, location, direction)


func handle_hitzaku():
	if dash.is_dashing(): return
	health -=10
	print(health)



func handle_hitbazookachar():
	if dash.is_dashing(): return
	health-=100
	


func handle_hitmeleechar():
	if dash.is_dashing(): return
	health-=300
	


func handle_hitzakuchar():
	if dash.is_dashing(): return
	health -=15
	print(health)

