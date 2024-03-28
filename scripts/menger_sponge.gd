extends Node3D

signal generate_mesh(pos: Vector3, side: float)

var box_scene = preload("res://scenes/box.tscn")

func _ready():
	$".".add_child(box_scene.instantiate())
	emit_signal("generate_mesh", Vector3.ZERO, 1)
	
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		# initiate fractal
		pass
