extends KinematicBody2D

signal stat_changed(stat)

enum { CANCEL=-1, EAT, PLAY, NEEDLE, DUCK, TOILET, SPRAY }

const STOMACH_MAX = 100
const HAPPINESS_MAX = 100
const HEALTH_MAX = 100
const HYGIENE_MAX = 100

var stomach = STOMACH_MAX
var happiness = HAPPINESS_MAX
var health = HEALTH_MAX
var hygiene = HYGIENE_MAX

var stats = [stomach, happiness, health, hygiene]

onready var anim = $AnimationPlayer
onready var timer = $AnimationTimer


func _ready():
	pass # Replace with function body.


func _on_animation_started(anim_name):
	pass


func _on_animation_finished(anim_name):
	timer.stop()
	if anim_name == "poop":
		anim.play("idle")


func _on_AnimationTimer_timeout():
	anim.play("idle")


func _on_action_taken(action):
	if action == CANCEL:
		timer.stop()
		anim.play("idle")		
	else:
		if timer and timer.is_stopped():
			timer.start()
		
			match action:
				EAT:
					anim.play("eat")
					
				PLAY:
					pass
					
				NEEDLE:
					anim.play("inject")
					
				DUCK:
					anim.play("bathe")
					
				TOILET:
					anim.play("poop")
					
				SPRAY:
					pass
					
				_:
					pass
