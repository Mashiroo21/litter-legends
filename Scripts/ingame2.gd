extends Node3D

# Referensi ke penghalang, timer, dan label
@export var barrier_node_path: NodePath = "Barrier"
@export var timer_label_path: NodePath = "Time"

var barrier: Node3D
var timer_label: Label

# Durasi waktu dalam detik
var total_game_time: float = 180.0  # 3 menit
var barrier_duration: float = 40.0  # Barrier bertahan 40 detik
var time_remaining: float = total_game_time  # Waktu tersisa untuk permainan

func _ready():
	# Dapatkan node penghalang dan label
	barrier = get_node(barrier_node_path)
	timer_label = get_node(timer_label_path)

	# Aktifkan _process untuk memperbarui waktu
	set_process(true)

func _process(delta):
	# Kurangi waktu berdasarkan delta (waktu frame)
	if time_remaining > 0:
		time_remaining -= delta

		# Jika waktu tersisa lebih kecil dari barrier_duration, hapus penghalang
		if time_remaining <= total_game_time - barrier_duration and barrier != null:
			barrier.queue_free()
			barrier = null  # Pastikan tidak mencoba menghapus dua kali

		# Perbarui label waktu
		update_timer_label()

	else:
		# Jika waktu habis, hentikan permainan (tambah logika selesai game di sini)
		print("Waktu habis! Permainan selesai.")
		set_process(false)

func update_timer_label():
	# Format waktu dalam menit dan detik
	var minutes = int(time_remaining) / 60
	var seconds = int(time_remaining) % 60
	timer_label.text = "Time: %02d:%02d" % [minutes, seconds]
