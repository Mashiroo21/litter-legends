extends Node3D

var current_selected_character_name
var selection_area = preload("res://Scenes/selection_area.tscn")

func _ready() -> void:
	for character in $Characters.get_children():
		var selection_are_ins = selection_area.instantiate()
		character.add_child(selection_area.instantiate())

func character_selected(character_name):
	current_selected_character_name = character_name
	$CharcterLabel.text = current_selected_character_name
	for character in $Characters.get_children():
		character.get_child(character.get_child_count()-1).hide_selection()


func _on_button_pressed() -> void:
	if current_selected_character_name:
		Global.set_player_character(current_selected_character_name)
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
