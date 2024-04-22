extends Node2D

signal state_changed(new_state)

enum State{
	PATROL,
	ENGAGE
}

@onready var player_detection_zone = $"PlayerDetectionZone"
@onready var patrol_timer = $"PatrolTimer"
@onready var _anim_sprite = $"AnimatedSprite2D"
var current_state: int = -1 : set = set_state
var player: Player = null
var weapon: Zaku_weapon = null
var actor: CharacterBody2D = null
#Patrol State
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2=Vector2.ZERO

func _ready():
	set_state(State.PATROL)

func _process(delta):
	if actor_velocity.x<0:
		actor._anim_sprite.play_left_animation()
	elif actor_velocity.x>0:
		actor._anim_sprite.play_right_animation()
	else:
		actor._anim_sprite.play_idle_animation()
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				actor.velocity=actor_velocity
				actor.move_and_slide()
				if actor.global_position.distance_to(patrol_location) < 5:
					patrol_location_reached=true
					actor_velocity=Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:
			if player !=null and weapon!= null:
				weapon.shoot()
				actor._anim_sprite.play_idle_animation()
				pass
			else:
				print("In Engage but no weapon/player")
		_:
			print ("in a state that should not exist")


func initialize(actor:CharacterBody2D, weapon: Zaku_weapon):
	self.actor=actor
	self.weapon=weapon

func set_state(new_state:int ):
	if new_state == current_state:
		return
	if new_state == State.PATROL:
		origin=global_position
		patrol_timer.start()
		patrol_location_reached = true
		
	
	
	current_state = new_state  
	emit_signal("state_changed", current_state)



func _on_player_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body


func _on_player_detection_zone_body_exited(body):
	if player and body == player:
		set_state(State.PATROL)
		player=null



func _on_patrol_timer_timeout():
	var patrol_range=150
	var random_x = randi_range(-patrol_range,patrol_range)
	var random_y = randi_range(-patrol_range,patrol_range)
	patrol_location = Vector2(random_x,random_y) + origin
	patrol_location_reached = false
	actor_velocity = actor.global_position.direction_to(patrol_location) * 100
	
