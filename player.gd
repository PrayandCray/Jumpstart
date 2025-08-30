extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 250
const JUMP_VELOCITY = -320

var direction = 1

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

		if velocity.y < 0:
			animated_sprite_2d.play("Jump" if direction == 1 else "Jump Left")
		else:
			animated_sprite_2d.play("Fall" if direction == 1 else "Fall Left")

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_axis("Strafe Left", "Strafe Right")

	if input_dir != 0:
		direction = input_dir
		velocity.x = direction * SPEED

		if is_on_floor():
			if direction == 1:
				animated_sprite_2d.play("Run Right")
			else:
				animated_sprite_2d.play("Run Left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		if is_on_floor():
			animated_sprite_2d.play("Idle")
			
	if global_position.y > 1000:
		global_position = Vector2(506, 460)

	move_and_slide()
