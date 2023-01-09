extends Node2D

var objective = 99


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		get_tree().change_scene("res://source/levels/Map.tscn")
