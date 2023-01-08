extends Area2D

var player_in_nest:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_BitonioNest_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_nest = true


func _on_BitonioNest_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_nest = false
