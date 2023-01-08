extends Area2D


onready var anim_player = $AnimationPlayer

var stunned: bool = false
var attacking: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if !attacking:
		anim_player.play("idle")


func _on_Tentacle_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		print("stun")
		stunned = true

func _on_Attackbox_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		attacking = true
		print("attack")
		anim_player.play("attack")
