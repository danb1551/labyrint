extends CharacterBody3D

@export var move_speed := 10.0
@export var mouse_sensitivity := 0.1
@export var gravity := 65.0
@export var jump_velocity := 10.0
@export var mys_chytat := true

var camera
var rotation_y := 0.0
var rotation_x := 0.0

func _ready():
	camera = $Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mys_chytat = true

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mys_chytat = false

	if event is InputEventMouseMotion and mys_chytat:
		rotation_y -= event.relative.x * mouse_sensitivity
		rotation_x -= event.relative.y * mouse_sensitivity
		rotation_x = clamp(rotation_x, -90, 90)

		rotation_degrees.y = rotation_y
		camera.rotation_degrees.x = rotation_x

func _physics_process(delta):
	# GRAVITACE
	if is_on_floor():
		pass
		#print("The object is on the floor!")

	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			velocity.y = jump_velocity
		else:
			velocity.y = 0.0
	elif not is_on_floor():
		velocity.y -= gravity * delta

	# RESET PO PÁDU
	if global_position.y < -55:
		global_position = Vector3(1, 15, 1)

	# POHYB
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		input_dir -= transform.basis.z
	if Input.is_action_pressed("ui_down"):
		input_dir += transform.basis.z
	if Input.is_action_pressed("ui_left"):
		input_dir -= transform.basis.x
	if Input.is_action_pressed("ui_right"):
		input_dir += transform.basis.x
	if Input.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mys_chytat = false

	input_dir = input_dir.normalized()
	var horizontal_velocity = input_dir * move_speed

	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z

	move_and_slide()  # ← SPRÁVNÉ volání v Godot 4
