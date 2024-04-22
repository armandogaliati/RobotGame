extends Sprite2D

var mpos = Vector2()
var pos = Vector2()
var rot   
func _process(delta):
	mpos = get_global_mouse_position()
	pos = global_position
	rot = rad_to_deg((mpos - pos).angle())

	if(rot >= -90 and rot <= 90):
		self.set_flip_v(false)
	else:
		self.set_flip_v(true)
