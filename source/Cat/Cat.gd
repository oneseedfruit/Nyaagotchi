extends KinematicBody2D

signal stat_changed(stat)

enum { CANCEL=-1, EAT, PLAY, NEEDLE, DUCK, TOILET, SPRAY }

const SPEED = 80

const STOMACH_MAX = 100
const HAPPINESS_MAX = 100
const HEALTH_MAX = 100
const HYGIENE_MAX = 100

var stomach = STOMACH_MAX
var happiness = HAPPINESS_MAX
var health = HEALTH_MAX
var hygiene = HYGIENE_MAX

var stats = [stomach, happiness, health, hygiene]

var speed = 0
var move_vec = Vector2.LEFT

onready var sprites = $CatSprites
onready var anim = $AnimationPlayer
onready var timer = $AnimationTimer
onready var moveTimer = $MoveTimer
onready var directionTimer = $DirectionTimer


func _ready():
	pass


func _process(delta):	
	if move_vec.x == 0:
		anim.play("idle")
	elif speed > 0:
		anim.play("walk")


func _physics_process(delta):		
	var col = move_and_collide(move_vec * speed * delta)
	if col:
		if col.normal == Vector2.RIGHT:
			move_vec.x = 1
		elif col.normal == Vector2.LEFT:
			move_vec.x = -1			
			
	if move_vec.x == 1:
		sprites.scale.x = -1
	elif move_vec.x == -1:
		sprites.scale.x = 1
	

func _on_animation_started(anim_name):
	pass


func _on_animation_finished(anim_name):
	timer.stop()
	if anim_name == "poop":
		anim.play("idle")
		moveTimer.start()
		directionTimer.paused = false


func _on_AnimationTimer_timeout():
	anim.play("idle")
	moveTimer.start()
	directionTimer.paused = false


func _on_action_taken(action):
	if action == CANCEL:
		timer.stop()	
		if anim.current_animation != "idle"	and anim.current_animation != "walk":
			anim.play("idle")
		moveTimer.start()
		directionTimer.paused = false
	else:
		if timer and timer.is_stopped():
			timer.start()
			moveTimer.stop()
			directionTimer.paused = true
		
			match action:
				EAT:
					speed = 0
					anim.play("eat")
					
				PLAY:					
					pass
					
				NEEDLE:
					speed = 0
					anim.play("inject")
					
				DUCK:
					speed = 0
					anim.play("bathe")
					
				TOILET:
					speed = 0
					anim.play("poop")
					
				SPRAY:					
					pass
					
				_:
					pass


func _on_MoveTimer_timeout():
	speed = SPEED


func _on_DirectionTimer_timeout():
	if rand_range(0, 100) < 50:
		move_vec.x = -1
	else:
		move_vec.x = 1
	if rand_range(0, 100) < 5:
		move_vec.x = 0
	randomize()
