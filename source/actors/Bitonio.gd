extends KinematicBody2D


onready var player = get_tree().get_nodes_in_group("player")[0]
onready var nest = get_parent()

onready var attack_timer = $Attackbox/AttackTimer
onready var knockback_timer = $Hitbox/KnockbackTimer
onready var anim_player = $AnimationPlayer

onready var sprite = $Sprite

var speed = 300

var is_attacking: bool = false
var attack_direction: Vector2

var motion: Vector2 = Vector2.ZERO

var knockback: Vector2
var knockback_speed: int = 1000
var is_knocked_back: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if motion.x > 0:
		sprite.flip_h = true
	else: sprite.flip_h = false
	if nest.player_in_nest:
		if !is_attacking and !is_knocked_back:
			motion = global_position.direction_to(player.global_position) * speed
	else:
		motion = Vector2.ZERO
		#roam()
		
	move_and_slide(motion)


func roam():
	pass

func _on_Attackbox_body_entered(body: Node) -> void:
	if !is_attacking and body.is_in_group("player"):
		is_attacking = true
		speed = 1000
		motion = global_position.direction_to(player.position) * speed
		attack_direction = motion
		attack_timer.start()


func _on_AttackTimer_timeout() -> void:
	is_attacking = false
	speed = 300


func _on_KnockbackTimer_timeout() -> void:
	is_knocked_back = false
	speed = 300
	anim_player.play("walk")


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		anim_player.play("knocked")
		is_attacking = false
		is_knocked_back = true
		knockback = global_position - area.global_position
		knockback = (knockback.normalized() * knockback_speed)
		knockback_timer.start()
		
		motion = knockback
