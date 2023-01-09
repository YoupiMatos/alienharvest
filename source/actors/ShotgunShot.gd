extends Sprite


export var speed: int = 4
var direction:= Vector2.ZERO

onready var canvas_mod = get_tree().get_nodes_in_group("canvas_mod")[0] as CanvasModulate
onready var timer = $IlluminationTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_toplevel(true)
	canvas_mod.set_color(Color("c4c4c4"))


func _process(delta: float) -> void:
	global_position += direction * speed * delta

func set_direction(new_direction: Vector2):
	self.direction = new_direction


func _on_IlluminationTimer_timeout() -> void:
	canvas_mod.set_color(Color("2c2c2c"))
