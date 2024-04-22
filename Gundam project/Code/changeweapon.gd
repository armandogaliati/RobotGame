extends Node2D
@onready var current_weapon: Weapon= $weapon
@onready var gundrif = $"../GUI/Rows/TextureRect/gundrif"
@onready var hyperb = $"../GUI/Rows/TextureRect/hyperbazooka"
@onready var saber = $"../GUI/Rows/TextureRect/saber"
var weapons: Array=[]

func _ready() ->void:
	weapons = get_children()
	
	#for weapon in weapons:
		#weapon.hide()

func switch_weapon(weapon: Weapon):
	if weapon == current_weapon:
		return
	current_weapon.hide()
	weapon.show()
	current_weapon=weapon

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		current_weapon.shoot()
	elif event.is_action_released("weapon_1"):
		switch_weapon(weapons[0])
		gundrif.visible=true
		hyperb.visible=false
		saber.visible=false
	elif event.is_action_released("weapon_2"):
		switch_weapon(weapons[1])
		hyperb.visible=true
		gundrif.visible=false
		saber.visible=false
	elif event.is_action_released("weapon_3"):
		switch_weapon(weapons[2])
		hyperb.visible=false
		gundrif.visible=false
		saber.visible=true
