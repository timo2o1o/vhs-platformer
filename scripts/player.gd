extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0

var animation_playing := false
var double_jump_available := true

var active := true

@onready var animated_sprite_2d := $AnimatedSprite2D
@onready var jump_sound := $JumpSound


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and active:
		if is_on_floor():
			double_jump_available = true
			jump()
		elif double_jump_available:
			play_animation("double_jump")
			jump()
			double_jump_available = false
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and active:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animations()

func reset(set_to_position :Vector2) -> void:
	velocity = Vector2(0,0)
	position = set_to_position
	play_animation("appear")
	
func die(set_to_position :Vector2) -> void:
	play_animation("death")
	reset(set_to_position)
		
func play_animation(animation_name :StringName) -> void:
	if !animation_playing:
		animation_playing = true
		animated_sprite_2d.play(animation_name)
		await animated_sprite_2d.animation_finished
		animation_playing = false
	
func jump(jump_scale :int = 1):
	velocity.y = JUMP_VELOCITY * jump_scale
	jump_sound.play()
	
	
func update_animations():
	
	if !animation_playing:
		if velocity.x < 0:
			animated_sprite_2d.flip_h = true
		elif velocity.x > 0:
			animated_sprite_2d.flip_h = false
		
		if !is_on_floor():
			if velocity.y < 0:
				animated_sprite_2d.play("jump")
			elif velocity.y > 0:
				animated_sprite_2d.play("fall")
		else:
			if velocity.x == 0:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("run")
				
