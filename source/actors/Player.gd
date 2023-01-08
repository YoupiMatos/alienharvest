extends KinematicBody2D

# Player var
export var speed: = 900

onready var objective = get_tree().get_nodes_in_group("level")[0].objective

onready var dodge_timer = $DodgeTimer
onready var shoot_timer = $ShootTimer
onready var end_of_gun = $shoot
onready var health = $CanvasLayer/Health
onready var eggs_label = $CanvasLayer/EggCount

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var motion : Vector2 = Vector2()
var is_dodging : bool = false
var dodge_direction: Vector2
var invicible: bool = false

var can_shoot: bool = true

var hp: int = 5
var egg_count: int = 0

# Bullet var
var bullet_speed = 3000
var bullet = preload("res://source/actors/Bullet.tscn")
var blaster_shot = preload("res://source/actors/BlasterShot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if egg_count == objective:
		eggs_label.text = "You've got all eggs. Return to base!"
	else: eggs_label.text = "Eggs : %s" % egg_count
	
	health.frame = hp
	#warning-ignore:return_value_discarded
	
	# Pour pas aller plus vite en diagonale
	motion = motion.normalized() * speed
	move_and_slide(motion)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	manage_input()



func fire():
	var blaster_shot_instance = blaster_shot.instance()
	blaster_shot_instance.global_position = end_of_gun.global_position
	blaster_shot_instance.rotation = rotation
	blaster_shot_instance.play_shot()
	
	get_tree().get_root().call_deferred("add_child", blaster_shot_instance)

func manage_input():
	if Input.is_action_just_pressed("dodge"):
		is_dodging = true
		dodge_direction = motion
		dodge_timer.start()
	if Input.is_action_just_pressed("fire") and can_shoot:
		fire()
		can_shoot = false
		shoot_timer.start()
		
	if is_dodging:
		speed = 1200
	else:
		speed = 600
		motion.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		motion.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		motion.y /= 2

func take_damage():
	$Sprite.modulate = Color(255, 0, 0)
	hp -= 1

func get_egg():
	egg_count += 1

func _on_Timer_timeout():
	is_dodging = false
	
func _on_ShootTimer_timeout() -> void:
	can_shoot = true


func _on_Hurtbox_body_entered(body: Node) -> void:
	if body.is_in_group("enemy") and !invicible:
		print("hurt")
		take_damage()



