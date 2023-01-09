extends Node2D

var missions = {
	"Base": "That's the base of operations, where I package and send the eggs. It's also where I game if I've got spare time. I never have spare time these days...",
	
	"Bitonio enclosure": "It's that time of the month where we harvest Bitonio eggs. They're almost harmless but they'll get angry if I get too close to the eggs. Lucky I've got my blaster ready!",
	
	"Tentacle field": "Them tentacles need to put their egg in the sun to have them grow. It's also the best time to try and get them. They'll try and squish me if I'm not too careful, so I brought my electric rifle to stun them.",
	
	"Unknown alien cave": "I've got a message saying that a cave far from base had some rare aliens in it. The egg is worth thousands! If I can get it I'll be able to wipe my debts, so it's probably worth it. What's the worst that can happen anyway?"
}

var objectives = [
	"Objective : Read the note",
	"Objective : Get 12 Bitonio eggs",
	"Objective : Get 7 Tentacle eggs",
	"Objective : Get 1 unkown alien egg"
]

onready var level_name = $LevelName
onready var level_description = $LevelDescription
onready var level_objective = $LevelObjective

var level_0 = "res://source/levels/Base.tscn"
var level_1 = "res://source/levels/Level1.tscn"
var level_2 = "res://source/levels/Level2.tscn"
var level_3 = "res://source/levels/Level3_intro.tscn"

var levels = [level_0, level_1, level_2, level_3]

var selected_level = 0

func _ready():
	level_name.text = missions.keys()[0]
	level_description.text = missions.values()[0]
	level_objective.text = objectives[0]


func _on_LevelTuto_pressed() -> void:
	level_name.text = missions.keys()[0]
	level_description.text = missions.values()[0]
	level_objective.text = objectives[0]
	selected_level = 0

func _on_Level1_pressed() -> void:
	if Autoload.base_complete:
		level_name.text = missions.keys()[1]
		level_description.text = missions.values()[1]
		level_objective.text = objectives[1]
		selected_level = 1
	else:
		level_name.text = 'LOCKED'
		level_description.text = "Visit the base first!"
		level_objective.text = "???"

func _on_Level2_pressed() -> void:
	if Autoload.level_1_complete:
		level_name.text = missions.keys()[2]
		level_description.text = missions.values()[2]
		level_objective.text = objectives[2]
		selected_level = 2
	else:
		level_name.text = 'LOCKED'
		level_description.text = "Finish the first level first!"
		level_objective.text = "???"

func _on_Level3_pressed() -> void:
	if Autoload.level_1_complete and Autoload.level_2_complete:
		level_name.text = missions.keys()[3]
		level_description.text = missions.values()[3]
		level_objective.text = objectives[3]
		selected_level = 3
	else:
		level_name.text = 'LOCKED'
		level_description.text = "Finish the first two levels first!"
		level_objective.text = "???"

func _on_StartButton_pressed() -> void:
	get_tree().change_scene(levels[selected_level])
