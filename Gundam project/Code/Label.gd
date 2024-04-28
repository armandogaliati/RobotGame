extends Label

var score = 0
@onready var enemy=get_tree().get_nodes_in_group("enemy")
@onready var game= $"../../.."

func handle_enemy_death():
	score += 1
	text = "Score: %s" % score
	if score==enemy.size():
		game.spawn_char()
