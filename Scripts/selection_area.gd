extends Area3D

@onready var ap = $"../AnimationPlayer"
@onready var character = get_parent()
@onready var character_selection_scene = get_tree().get_root().get_node("CharacterSelection")
signal character_selected

func _ready() -> void:
	connect("character_selected",character_selection_scene.character_selected)
	ap.connect("animation_finished",_on_animation_player_animation_finished)

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		ap.play("emote-yes")
		emit_signal("character_selected",character.name)
		$Selection.show()


func hide_selection():
	$Selection.hide()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "emote-yes":
		ap.play("idle")
