extends KinematicBody2D


var motion: Vector2 = Vector2.ZERO
var speed = 600
var attacking = false

onready var player = get_tree().get_nodes_in_group("player")[0]

onready var sprite = $Sprite
onready var attack_timer = $AttackTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Sprite looking the right way
	if motion.x > 0:
		sprite.flip_h = true
	else: sprite.flip_h = false
	if attacking:
		motion = attack()
	
	move_and_slide(motion)
	

func attack() -> Vector2:
	var new_motion = global_position.direction_to(player.global_position) * speed
	return new_motion
	
func roam() -> Vector2:
	var new_motion = global_position.direction_to(
		Vector2(
			randi() % player.camera.limit_right,
			randi() % player.camera.limit_bottom
			)
		) * speed
	return new_motion


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		attacking = false
		attack_timer.start()
		$HurtAudio.play()
		motion = global_position.direction_to(
			Vector2(
				randi() % player.camera.limit_right,
				randi() % player.camera.limit_bottom
				)
			) * speed


func _on_AttackTimer_timeout() -> void:
	attacking = true
	$AttackAudio.play()
