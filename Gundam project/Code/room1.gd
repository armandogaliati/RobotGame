extends Node2D

const GameOverScreen = preload ("res://Gundam project/Scenes/GameOverScreen.tscn")
@onready var bullet_manager = $BulletManager
@onready var player = $player
@onready var score_manager= $player/Control/Label
var scene_to_instance = preload("res://Gundam project/Scenes/char_zaku.tscn")

func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager.handle_bullet_spawned)
	GlobalSignals.connect("enemydied",score_manager.handle_enemy_death)


func handle_player_dead():
	var game_over=GameOverScreen.instance()
	add_child(game_over)
	get_tree().paused = true
	

func spawn_char():
	var object = scene_to_instance.instantiate()
	call_deferred("add_child",object)
