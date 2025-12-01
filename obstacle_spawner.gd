extends Node2D

@export var obstacle_scenes: Array[PackedScene] = []

var difficulty := 0.0
var next_spawn_time := 0.0

func _ready():
	randomize()
	set_next_spawn_time(0.0)

func _process(delta):
	next_spawn_time -= delta
	
	if next_spawn_time <= 0:
		spawn_obstacle()
		
		
		difficulty += 0.1 

func set_next_spawn_time(delay: float):
	next_spawn_time = delay

func spawn_obstacle():
	if obstacle_scenes.is_empty():
		return

	var scene = obstacle_scenes.pick_random()
	var obstacle = scene.instantiate()
	obstacle.position = position
	get_parent().add_child(obstacle)

	var current_speed = 350 + (difficulty * 25)
	obstacle.speed = current_speed
	
	var obstacle_width = 100.0 
	
	if obstacle.has_node("BitisNoktasi"):
		obstacle_width = obstacle.get_node("BitisNoktasi").position.x * obstacle.scale.x
	
	var mandatory_time = obstacle_width / current_speed
	

	
	var calculated_min_gap = 0.8 - (difficulty * 0.05)
	var calculated_max_gap = 1.5 - (difficulty * 0.08)
	
	
	
	var final_min_gap = max(0.5, calculated_min_gap)
	var final_max_gap = max(final_min_gap + 0.3, calculated_max_gap)
	
	var random_gap = randf_range(final_min_gap, final_max_gap)
	
	set_next_spawn_time(mandatory_time + random_gap)
