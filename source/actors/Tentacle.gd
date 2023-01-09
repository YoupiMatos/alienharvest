extends Area2D


onready var player = get_tree().get_nodes_in_group("player")[0]

onready var anim_sprite = $Sprite
onready var stun_timer = $StunTimer
onready var attack_hitbox = $Attack/Attack

var stunned: bool = false
var attacking: bool = false
var flipped: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if !stunned and !attacking:
		anim_sprite.play("idle")
		
	if anim_sprite.animation == "attack":
		anim_sprite.offset = Vector2(-30,30)
	else:
		anim_sprite.offset = Vector2(0,0)
		
	if global_position.direction_to(player.global_position).x > 0:
		flipped = true
		anim_sprite.flip_h = true
		if attacking:
			anim_sprite.offset.x = 60
		else: anim_sprite.offset.x = 30
	else: 
		flipped = false
		anim_sprite.flip_h = false


func _on_Tentacle_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		anim_sprite.play("stun")
		stunned = true
		stun_timer.start()

func _on_Attackbox_body_entered(body: Node) -> void:
	if body.is_in_group("player") and !stunned:
		attack_hitbox.set_deferred("disabled", false)
		attacking = true
		print("attack")
		anim_sprite.play("attack")
		if flipped:
			anim_sprite.offset.x = 60
		else:
			anim_sprite.offset = Vector2(-30, 30)

func _on_Attackbox_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		attacking = false
		attack_hitbox.set_deferred("disabled", true)


func _on_StunTimer_timeout() -> void:
	stunned = false

