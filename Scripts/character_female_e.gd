extends Node3D

@export var speed = 14  # Kecepatan gerak karakter
@export var fall_acceleration = 75  # Gravitasi
@export var jump_impulse = 20  # Impuls lompatan
@export var ground_check_distance = 0.2  # Jarak untuk cek apakah di atas tanah

var velocity = Vector3.ZERO  # Kecepatan karakter
var target_velocity = Vector3.ZERO  # Kecepatan target berdasarkan input
var is_jumping = false  # Status apakah karakter sedang melompat

# Referensi node anak
@onready var animation_player = $AnimationPlayer
@onready var mesh = $MeshInstance3D  # Ganti sesuai nama node visual Anda

func _ready():
	animation_player.play("idle")  # Mainkan animasi idle saat mulai

func play_animation(anim_name: String):
	# Fungsi untuk memutar animasi tertentu
	animation_player.play(anim_name)

func _physics_process(delta):
	var direction = Vector3.ZERO

	# Input pergerakan
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	# Normalisasi arah jika ada input
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Rotasi mesh agar menghadap arah gerakan
		mesh.look_at(global_transform.origin + direction, Vector3.UP)
		# Aktifkan animasi berjalan
		play_animation("walk")
	else:
		# Jika tidak ada input, kembali ke animasi idle
		play_animation("idle")

	# Perhitungan lompatan
	if not is_jumping and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_impulse
		is_jumping = true
		play_animation("jump")

	# Gravitasi
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta
	else:
		velocity.y = 0
		is_jumping = false

	# Atur kecepatan target berdasarkan input
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Update posisi (manual karena Node3D tidak punya move_and_slide)
	velocity.x = target_velocity.x
	velocity.z = target_velocity.z
	global_translate(velocity * delta)

func is_on_floor() -> bool:
	# Cek apakah karakter berada di atas tanah menggunakan raycast manual
	var from = global_transform.origin
	var to = from - Vector3.UP * ground_check_distance
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(from, to, [], collision_mask=1)
	return result.size() > 0
