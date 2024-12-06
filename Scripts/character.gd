class_name CharacterEx extends Node3D

@onready var animation_player = %AnimationPlayer
#@onready var state_machine : AnimationNodeStateMachinePlayback = animation_player.get("parameters/StateMachine/playback")
#@onready var move_tilt_path : String = "parameters/StateMachine/Move/tilt/add_amount"

#var run_tilt = 0.0 : set = _set_run_tilt

#@export var blink = true : set = set_blink
#@onready var blink_timer = %BlinkTimer
#@onready var closed_eyes_timer = %ClosedEyesTimer
#@onready var eye_mat = $sophia/rig/Skeleton3D/Sophia.get("surface_material_override/2")

func _ready():
	pass

#func set_blink(state : bool):
	#if blink == state: return
	#blink = state
	#if blink:
		#blink_timer.start(0.2)
	#else:
		#blink_timer.stop()
		#closed_eyes_timer.stop()

#func _set_run_tilt(value : float):
	#run_tilt = clamp(value, -1.0, 1.0)
	#animation_player.set(move_tilt_path, run_tilt)

func idle():
	animation_player.play("idle")

func move():
	animation_player.play("walk")

func fall():
	animation_player.play("fall")

func jump():
	animation_player.play("jump")

#func edge_grab():
	#state_machine.travel("EdgeGrab")

#func wall_slide():
	#state_machine.travel("WallSlide")
