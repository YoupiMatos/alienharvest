extends KinematicBody2D


onready var player = get_tree().get_nodes_in_group("player")[0]
onready var attack_timer = $Attackbox/AttackTimer

var speed = 300

var is_attacking: bool = false
var attack_direction: Vector2

var motion = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var look_vec = player.global_position - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	
	
	move_and_slide(motion)
	
	if !is_attacking:
		motion = position.direction_to(player.position) * speed


func _on_Attackbox_body_entered(body: Node) -> void:
	if !is_attacking and body.is_in_group("player"):
		is_attacking = true
		speed = 1000
		motion = position.direction_to(player.position) * speed
		attack_direction = motion
		attack_timer.start()
	

func _on_Attackbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		print("hit")
		motion = - position.direction_to(area.position)

func _on_AttackTimer_timeout() -> void:
	is_attacking = false
	speed = 300
