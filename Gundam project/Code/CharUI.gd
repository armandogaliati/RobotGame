extends CanvasLayer

@onready var health_bar = $ProgressBar

var char: Char

func set_char (char:Char):
	self.char = char
	
	set_new_health_value(char.health_stat.health)
	char.connect("char_health_changed", self.set_new_health_value)


func set_new_health_value(new_health: int):
	health_bar.value = new_health
