extends CharacterBody2D

const GRAVITY = 900
const JUMP_FORCE = -380
const FORWARD_IMPULSE = 120
const FRICTION = 1000


const JUMP_BUFFER_TIME = 0.2 
var jump_buffer_timer := 0.0 

func _process(delta):

	if Input.is_action_just_pressed("note_5"):
		play_note("sol.mp3")
	
	if Input.is_action_pressed("note_5"):
		scale.y = 0.7 
	else:
		scale.y = 1.0 


	if Input.is_action_just_pressed("note_1"):
		play_note("do.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME
	if Input.is_action_just_pressed("note_2"):
		play_note("re.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME
	if Input.is_action_just_pressed("note_3"):
		play_note("mi.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME
	if Input.is_action_just_pressed("note_4"):
		play_note("fa.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME
	
	if Input.is_action_just_pressed("note_6"):
		play_note("la.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME
	if Input.is_action_just_pressed("note_7"):
		play_note("si.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME
	if Input.is_action_just_pressed("note_8"):
		play_note("do2.mp3"); jump_buffer_timer = JUMP_BUFFER_TIME

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	
	if is_on_floor() and jump_buffer_timer > 0:
		velocity.y = JUMP_FORCE
		velocity.x = FORWARD_IMPULSE
		
		
		jump_buffer_timer = 0.0

	move_and_slide()
	

func play_note(file_name: String):
	var audio := AudioStreamPlayer.new()
	audio.stream = load("res://sounds/" + file_name)
	add_child(audio)
	audio.play()
	audio.finished.connect(func():
		audio.queue_free()
	)

func _on_area_2d_body_entered(body):
	if body.is_in_group("obstacle"):
		get_parent().game_over()
