extends Area2D

export var target_level: String

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_LevelChanger_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene(target_level)
