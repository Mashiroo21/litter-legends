extends Node3D

# Referensi ke penghalang dan label
@export var barrier_node_path: NodePath = "Barrier"
@export var timer_label_path: NodePath = "Time"
@export var warning_label_path: NodePath = "WarningLabel"

var barrier: Node3D
var timer_label: Label
var warning_label: Label

# Total waktu permainan (3 menit = 180 detik)
var total_game_time: float = 180.0
var barrier_duration: float = 30.0  # Barrier bertahan 30 detik
var time_remaining: float = total_game_time

var warning_active: bool = false  # Apakah peringatan sudah aktif
var warning_blink: bool = false  # Status kedipan teks

func _ready():
	# Dapatkan node penghalang dan label
	barrier = get_node(barrier_node_path)
	timer_label = get_node(timer_label_path)
	warning_label = get_node(warning_label_path)

	# Sembunyikan label peringatan di awal
	warning_label.visible = false

	# Aktifkan proses untuk menghitung waktu
	set_process(true)

func _process(delta):
	# Hitung waktu permainan
	if time_remaining > 0:
		time_remaining -= delta
		
		# Jika waktu tersisa lebih kecil dari barrier_duration, hapus penghalang
		if time_remaining <= total_game_time - barrier_duration and barrier != null:
			barrier.queue_free()
			barrier = null  # Pastikan tidak mencoba menghapus dua kali
			
		# Perbarui tampilan label timer
		update_timer_label()

		# Tampilkan peringatan jika waktu kurang dari 30 detik
		if time_remaining <= 30.0 and not warning_active:
			activate_warning()
			#print('debugging : check')
	#else:
		## Waktu habis, hentikan permainan
		#end_game()

func update_timer_label():
	# Format waktu menjadi MM:SS
	var minutes = int(time_remaining) / 60
	var seconds = int(time_remaining) % 60
	timer_label.text = "Time: %02d:%02d" % [minutes, seconds]

	# Ganti warna timer menjadi merah saat waktu kurang dari 30 detik
	if time_remaining <= 30.0:
		timer_label.set("theme_override_colors/font_color", Color.RED)
	else:
		timer_label.set("theme_override_colors/font_color", Color.WHITE)

func activate_warning():
	# Aktifkan peringatan
	warning_active = true
	warning_label.visible = true
	
	#Test WarningLabel
	warning_label.text = "Waktu Akan Habis!"
	warning_label.set("theme_override_colors/font_color", Color.YELLOW)

	# Jadikan teks berkedip
	#blink_warning()

func blink_warning():
	# Atur kedipan teks
	warning_blink = not warning_blink
	warning_label.visible = warning_blink

	# Jadwalkan kedipan setiap 0.5 detik
	call_deferred("blink_warning")

func end_game():
	# Matikan proses
	set_process(false)

	# Tampilkan pesan terakhir
	print("Waktu habis! Permainan selesai.")

	# Tutup aplikasi
	get_tree().quit()
