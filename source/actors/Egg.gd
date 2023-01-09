extends Area2D


onready var label = $Label

var picked_up = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	

#func _process(delta: float) -> void:
#	pass


# Get picked up
func _on_Node2D_body_entered(body: Node) -> void:
	if body.is_in_group("player") and picked_up == false:
		picked_up = true
		label.visible = true
		$Sprite.visible = false
		$LabelTimer.start()
		body.get_egg()
		queue_free()


func _on_LabelTimer_timeout() -> void:
	queue_free()
