extends Label

var score = 0

func handle_enemy_death():
	score += 1
	text = "Score: %s" % score
