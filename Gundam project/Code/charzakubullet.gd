extends Area2D
 
#
#@onready var player = get_parent().find_child("player")
@export var speed = 10
@onready var kill_timer=$KillTimer
var direction := Vector2.ZERO

func _ready():
	kill_timer.start()



func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity= direction * speed
		
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction=direction
	rotation+= direction.angle()


func _on_kill_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.has_method("handle_hitzakuchar"):
		body.handle_hitzakuchar()
		queue_free()

