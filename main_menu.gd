extends Node2D

@onready var start_button =$UI/StartButton
@onready var help_button = $UI/HelpButton
@onready var about_button = $UI/AboutButton

@onready var help_panel = $UI/HelpPanel
@onready var about_panel = $UI/AboutPanel

@onready var help_back = $UI/HelpPanel/BackButton
@onready var about_back = $UI/AboutPanel/BackButton

func _ready():
	$"UI/BackgroundMusic/Emotional-piano-438664".play()
	help_panel.visible = false
	about_panel.visible = false

	start_button.pressed.connect(_on_start_pressed)
	help_button.pressed.connect(_on_help_pressed)
	about_button.pressed.connect(_on_about_pressed)

	help_back.pressed.connect(_on_back_to_menu)
	about_back.pressed.connect(_on_back_to_menu)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_help_pressed():
	help_panel.visible = true
	about_panel.visible = false

func _on_about_pressed():
	about_panel.visible = true
	help_panel.visible = false

func _on_back_to_menu():
	help_panel.visible = false
	about_panel.visible = false
