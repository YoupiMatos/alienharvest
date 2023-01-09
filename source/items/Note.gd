extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Note_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		$Sprite.visible = true
		Autoload.base_complete = true
		body.objective_complete = true


func _on_Note_body_exited(body: Node) -> void:
	$Sprite.visible = false
