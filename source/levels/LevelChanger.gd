extends Area2D

onready var player = get_tree().get_nodes_in_group("player")[0]

export var target_level:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player.objective_complete:
		$Sprite.visible = false
		$CollisionShape2D.disabled = true
	else:
		$Sprite.visible = true
		$CollisionShape2D.disabled = false


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.objective_complete:
			get_tree().change_scene(target_level)
