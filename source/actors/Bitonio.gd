extends KinematicBody2D


onready var player = get_tree().get_nodes_in_group("player")[0]
onready var nest = get_parent() as Area2D

onready var attack_timer = $Attackbox/AttackTimer
onready var knockback_timer = $Hitbox/KnockbackTimer
onready var follow_timer = $FollowPlayerTimer
onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

var is_attacking: bool = false
var is_knocked_back: bool = false
var following_player: bool = false
var in_nest: bool = false

var attack_direction: Vector2
var motion: Vector2 = Vector2.ZERO
var knockback: Vector2

var texture1 = preload("res://assets/ennemies/bitonio_BLUE.png")
var texture2 = preload("res://assets/ennemies/bitonio_ORANGE.png")
var texture3 = preload("res://assets/ennemies/bitonio_ROSE.png")
var texture4 = preload("res://assets/ennemies/bitonio_VERT.png")
var textures = [texture1, texture2, texture3, texture4]

export var speed: int = 300
export var knockback_speed: int = 1000



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	sprite.texture = textures[randi() % 4]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Sprite looking the right way
	if motion.x > 0:
		sprite.flip_h = true
	else: sprite.flip_h = false
	
	if nest is Area2D:
		if nest.player_in_nest or following_player:
			if follow_timer.time_left == 0:
				follow_timer.start()
				following_player = true
			if !is_attacking and !is_knocked_back:
				motion = global_position.direction_to(player.global_position) * speed
		else:
			if !in_nest and !is_attacking:
				# go toward nest
				motion = global_position.direction_to(nest.global_position) * speed
			else:
				pass
		
	move_and_slide(motion)


func roam():
	pass
	

func _on_Attackbox_body_entered(body: Node) -> void:
	if !is_attacking and body.is_in_group("player"):
		is_attacking = true
		speed = 1200
		motion = global_position.direction_to(player.position) * speed
		attack_direction = motion
		attack_timer.start()


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		anim_player.play("knocked")
		is_attacking = false
		is_knocked_back = true
		knockback = global_position - area.global_position
		knockback = (knockback.normalized() * knockback_speed)
		knockback_timer.start()
		
		motion = knockback
		
	if area.is_in_group("bitonio_nest"):
		in_nest = true

func _on_Hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("bitonio_nest"):
		in_nest = false


func _on_AttackTimer_timeout() -> void:
	is_attacking = false
	speed = 300

func _on_KnockbackTimer_timeout() -> void:
	is_knocked_back = false
	speed = 300
	anim_player.play("walk")

func _on_FollowPlayerTimer_timeout() -> void:
	following_player = false
