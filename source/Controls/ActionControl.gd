extends Node2D

signal action_taken(action)

enum { CANCEL=-1, EAT, PLAY, NEEDLE, DUCK, TOILET, SPRAY }

var action = -1

func _on_MenuControl_execute_button_pressed(selected):
	action = selected
	emit_signal("action_taken", action)
	print(action)
