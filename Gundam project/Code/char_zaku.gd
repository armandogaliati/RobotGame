extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var anim = $AnimatedSprite2D
@onready var progress_bar=$UI/ProgressBar

var direction : Vector2

var health = 1000:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

func _ready():
	set_physics_process(false)
	
	
func _process(delta):
	direction = player.position - position
	if velocity.x<0:
		anim.play("walk_left")
	elif velocity.x>0:
		anim.play("walk_right")
	elif velocity.x==0:
		anim.play("idle")

func _physics_process(delta):
	velocity = direction.normalized()*600
	move_and_collide(velocity * delta)

func handle_hitbeam():
	health -=35

func handle_hitvulcan():
	health -=5

func handle_hitbazooka():
	health -=60

func handle_hitmelee():
	health -=100

