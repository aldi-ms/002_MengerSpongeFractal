extends Node3D

var cube_scene = preload("res://scenes/cube.tscn")
var sponge = []

func _ready():
	# create initial cube
	var cube: Cube = cube_scene.instantiate()
	$SpongeContainer.add_child(cube)
	# generate its mesh
	cube.gen_mesh(Vector3.ZERO, 1)
	# append it to the sponge
	sponge.append(cube)
	
func _process(delta):
	$SpongeContainer.rotate(Vector3(0.1, 0.1, 0.1).normalized(), 0.01)
	
	if Input.is_action_just_pressed("split_sponge"):
		var next_sponge = []
		while !sponge.is_empty():
			var cube = sponge.pop_front()
			next_sponge.append_array(split_cube(cube))
			
			# remove the original cube
			cube.queue_free()
			
		sponge = next_sponge
		
func split_cube(cube: Cube):
	var next_sponge = []
	var next_size = cube.side / 3
	
	# split cube in 3x3
	for x in range(-1, 2):
		for y in range(-1, 2):
			for z in range(-1, 2):
				var next_pos = cube.pos + Vector3(
					x * next_size, 
					y * next_size, 
					z * next_size)
				var next_cube: Cube = cube_scene.instantiate()
				$SpongeContainer.add_child(next_cube)
				next_cube.gen_mesh(next_pos, next_size)
				next_sponge.append(next_cube)
				
	return next_sponge
				
	# generate new 3x3 cubes, removing the middle ones
