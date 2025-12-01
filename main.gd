extends Node2D

var survived_time := 0
var time_passed := 0.0

@onready var score_label = $UI/ScoreLabel
@onready var game_over_panel = $UI/GameOverPanel
@onready var survived_label = $UI/GameOverPanel/SurvivedLabel
@onready var play_again_button = $UI/GameOverPanel/PlayAgainButton
@onready var main_back =$BackButton
@onready var pause =$pause
@onready var pausepanel =$UI/pausepanel
@onready var menubut =$UI/pausepanel/menubut
@onready var retbut =$UI/pausepanel/retbut




func _ready():
	get_tree().paused = false
	game_over_panel.visible = false
	score_label.text = "Survived: " + str(survived_time) + "s"
	pausepanel.visible=false
	# Buton sinyali bağlama
	play_again_button.connect("pressed", Callable(self, "_on_play_again_pressed"))
	main_back.pressed.connect(_on_back_to_menu)

func _process(delta):
	if get_tree().paused:
		return

	time_passed += delta
	if time_passed >= 1.0:
		time_passed = 0
		survived_time += 1
		score_label.text = "Survived: " + str(survived_time) + "s"

func game_over():
	get_tree().paused = true
	game_over_panel.visible = true
	survived_label.text = "Survived: " + str(survived_time) + "s"

func _on_play_again_button_pressed():
		game_over_panel.visible=false
		get_tree().change_scene_to_file("res://main.tscn")

func _on_back_to_menu():
		get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_pause_pressed():
	get_tree().paused = true
	pausepanel.visible=true
func _on_menubut_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
func _on_retbut_pressed():
		get_tree().paused = false
		pausepanel.visible=false
