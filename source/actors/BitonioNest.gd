extends Area2D

var player_in_nest:bool = false
var center: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_BitonioNest_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_nest = true


func _on_BitonioNest_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_nest = false
