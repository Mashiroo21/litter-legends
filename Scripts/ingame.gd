extends Node3D

# Referensi ke penghalang dan timer
@export var barrier_node_path: NodePath = "Barrier"
@export var timer_node_path: NodePath = "Timer"
@export var label_node_path: NodePath = "Time"

var barrier: Node3D
var timer: Timer
var timer_label: Label

var time_remaining: float = 40.0  # Waktu dalam detik (sesuai durasi timer)

func _ready():
	# Dapatkan node penghalang dan timer
	barrier = get_node(barrier_node_path)
	timer = get_node(timer_node_path)
	timer_label = get_node(label_node_path)

	# Mulai timer
	timer.start()

	# Hubungkan sinyal timer selesai ke fungsi untuk membuka penghalang
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	# Hubungkan metode untuk memperbarui waktu
	set_process(true)

func _process(delta):
	# Kurangi waktu berdasarkan delta (waktu frame)
	if time_remaining > 0:
		time_remaining -= delta
		if time_remaining < 0:
			time_remaining = 0  # Pastikan tidak negatif

		# Perbarui teks label
		timer_label.text = "Time: %.2f" % time_remaining

func _on_timer_timeout():
	# Debug untuk memastikan metode dipanggil
	print("Timer selesai, menghapus penghalang.")
	
	# Hapus penghalang dari scene
	if barrier:
		barrier.queue_free()
