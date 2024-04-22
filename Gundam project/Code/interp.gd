extends Sprite2D
#@onready var tween = get_tree().create_tween()

func _ready():
	randomize()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.5)
	tween.tween_callback(tween_all_completed)
 
func tween_all_completed():
	self.queue_free()
