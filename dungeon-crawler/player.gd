extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var attacking := false
var orbs : int = 0
@export var animation: AnimationPlayer
@onready var player: CharacterBody2D = $"."
@onready var sprite: Sprite2D = $Sprite2D




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if velocity.y < 0:
		animation.play("jump")
	elif velocity.y > 0:
		animation.play("fall")
	
	if Input.is_action_just_pressed("attack") and is_on_floor():
		attacking = true
	if attacking:
		animation.play("attack")
		await animation.animation_finished
		attacking = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	#print("direction = ", direction, " velocity x = ", velocity.x, " velocity y = ", velocity.y)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
	if is_on_floor():
			
		if direction != 0 && velocity.x:
			animation.play("run")
		elif direction == 0 && !velocity.x:
			animation.play("idle")
	print_rich("orbs = ", orbs)
	move_and_slide()
