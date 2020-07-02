extends Node2D

signal execute_button_pressed(selected)

var selected = -1

var IconEatSelected = preload("res://UI/Icons/IconEat.PNG")
var IconPlaySelected = preload("res://UI/Icons/IconPlay.PNG")
var IconNeedleSelected = preload("res://UI/Icons/IconNeedle.PNG")
var IconDuckSelected = preload("res://UI/Icons/IconDuck.PNG")
var IconToiletSelected = preload("res://UI/Icons/IconToilet.PNG")
var IconSpraySelected = preload("res://UI/Icons/IconSpray.PNG")

var IconEatEnabled = preload("res://UI/IconsEnabled/IconEat.PNG")
var IconPlayEnabled = preload("res://UI/IconsEnabled/IconPlay.PNG")
var IconNeedleEnabled = preload("res://UI/IconsEnabled/IconNeedle.PNG")
var IconDuckEnabled = preload("res://UI/IconsEnabled/IconDuck.PNG")
var IconToiletEnabled = preload("res://UI/IconsEnabled/IconToilet.PNG")
var IconSprayEnabled = preload("res://UI/IconsEnabled/IconSpray.PNG")

var IconEatDisabled = preload("res://UI/IconsDisabled/IconEat.PNG")
var IconPlayDisabled = preload("res://UI/IconsDisabled/IconPlay.PNG")
var IconNeedleDisabled = preload("res://UI/IconsDisabled/IconNeedle.PNG")
var IconDuckDisabled = preload("res://UI/IconsDisabled/IconDuck.PNG")
var IconToiletDisabled = preload("res://UI/IconsDisabled/IconToilet.PNG")
var IconSprayDisabled = preload("res://UI/IconsDisabled/IconSpray.PNG")

onready var IconEat = get_parent().get_node("UI/Icons/IconEat")
onready var IconPlay = get_parent().get_node("UI/Icons/IconPlay")
onready var IconNeedle = get_parent().get_node("UI/Icons/IconNeedle")
onready var IconDuck = get_parent().get_node("UI/Icons/IconDuck")
onready var IconToilet = get_parent().get_node("UI/Icons/IconToilet")
onready var IconSpray = get_parent().get_node("UI/Icons/IconSpray")

var icons
var iconsSelectedTexture
var iconsEnabledTexture
var iconsDisabledTexture

onready var MenuTimer = get_parent().get_node("MenuTimer")


func _ready():
	icons = [
		IconEat, 
		IconPlay,
		IconNeedle,
		IconDuck,
		IconToilet,
		IconSpray		
		]
	iconsSelectedTexture = [
		IconEatSelected,
		IconPlaySelected,
		IconNeedleSelected,
		IconDuckSelected,
		IconToiletSelected,
		IconSpraySelected
	]
	iconsEnabledTexture = [
		IconEatEnabled,
		IconPlayEnabled,
		IconNeedleEnabled,
		IconDuckEnabled,
		IconToiletEnabled,
		IconSprayEnabled
	]
	iconsDisabledTexture = [
		IconEatDisabled,
		IconPlayDisabled,
		IconNeedleDisabled,
		IconDuckDisabled,
		IconToiletDisabled,
		IconSprayDisabled
	]


func _on_ButtonSelect_pressed():
	selected += 1
	selected %= 6
		
	for i in range(0, icons.size()):
		if icons[i] == icons[selected]:
			icons[i].texture = iconsSelectedTexture[i]
		else:
			icons[i].texture = iconsEnabledTexture[i]

	MenuTimer.start()


func _on_ButtonCancel_pressed():	
	selected = -1
	
	for i in range(0, icons.size()):
		icons[i].texture = iconsEnabledTexture[i]
		
	emit_signal("execute_button_pressed", selected)
	MenuTimer.stop()


func _on_ButtonExecute_pressed():
	emit_signal("execute_button_pressed", selected)	
	MenuTimer.start()


func _on_MenuTimer_timeout():
	_on_ButtonCancel_pressed()
