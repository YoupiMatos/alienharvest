extends KinematicBody2D

# Player var
export var speed: = 600

onready var dodge_timer = $Timer
onready var raycast = $RayCast2D
onready var end_of_gun = $shoot

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var motion : Vector2 = Vector2()
var is_dodging : bool = false
var dodge_direction

# Bullet var
var bullet_speed = 2000
var bullet = preload("res://source/actors/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	speed = speed
	if is_dodging:
		speed = 1200
	else:
		speed = 600
		motion.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		motion.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		motion.y /= 2	
	#warning-ignore:return_value_discarded
	
	# Pour pas aller plus vite en diagonale
	motion = motion.normalized() * speed
	move_and_slide(motion)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("dodge"):
		is_dodging = true
		dodge_direction = motion
		dodge_timer.start()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		fire()

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = end_of_gun.global_position
	var target = get_global_mouse_position()
	var direction_to_mouse = bullet_instance.global_position.direction_to(target).normalized()
	bullet_instance.set_direction(direction_to_mouse)
	
	get_tree().get_root().call_deferred("add_child", bullet_instance)


func _on_Timer_timeout():
	is_dodging = false
