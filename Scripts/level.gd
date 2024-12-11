extends Node3D

var player

func _ready() -> void:
	get_player_character()
	var player_ins = player.instantiate()
	add_child(player_ins)
	player_ins.position = $PlayerPos.position

func get_player_character():
	match Global.player_character:
		"RINI":
			player = load("res://Scenes/character-female-e2.tscn")
		"RANI":
			player = load("res://Scenes/character_female_f_2.tscn")
		"ROBET":
			player = load("res://Scenes/character_male_a_2.tscn")
		"RANGGA":
			player = load("res://Scenes/character_male_f_2.tscn")
		
		_:player = load("res://Scenes/character-female-e2.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/character_selection.tscn")
