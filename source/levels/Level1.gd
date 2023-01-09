extends Node2D

var objective = 12

onready var player = get_tree().get_nodes_in_group("player")[0]

func _process(delta: float) -> void:
	if player.objective_complete:
		Autoload.level_1_complete = true
