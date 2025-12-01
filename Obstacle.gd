extends Node2D

@export var speed := 300

func _process(delta):
	position.x -= speed * delta

		
