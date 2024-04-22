extends CanvasLayer


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Gundam project/Scenes/room1.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
