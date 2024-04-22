extends CanvasLayer

@onready var health_bar = $Rows/TextureRect/HealthBar

var player: Player

func set_player (player: Player):
	self.player = player
	
	set_new_health_value(player.health_stat.health)
	player.connect("player_health_changed", self.set_new_health_value)


func set_new_health_value(new_health: int):
	health_bar.value = new_health
