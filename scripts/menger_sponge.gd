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
	$SpongeContainer.rotate(Vector3(0.1, 0.1, 0.1).normalized(), delta * .6)
	
	if Input.is_action_just_pressed("split_sponge"):
		var next_sponge = []
		while !sponge.is_empty():
			var cube = sponge.pop_front()
			next_sponge.append_array(split_cube(cube))
			
			# remove the original cube
			cube.queue_free()
			
		sponge = next_sponge
		
func split_cube(cube: Cube):
	var next_gen = []
	var next_size = cube.side / 3.0
	
	# split cube in 3x3
	for x in range(0, 3):
		for y in range(0, 3):
			for z in range(0, 3):
				if check_cube_pos(x, y, z):
					# center/middle cube, dont create it
					continue
					
				var next_pos = cube.pos + Vector3(
					x * next_size, 
					y * next_size, 
					z * next_size)
				var next_cube: Cube = cube_scene.instantiate()
				$SpongeContainer.add_child(next_cube)
				next_cube.gen_mesh(next_pos, next_size)
				next_gen.append(next_cube)
				
	return next_gen
	
func check_cube_pos(x, y, z):
	if Vector3(x, y, z) == Vector3.ONE:
		return true
	return (x == 1 && y == 1) || (x == 1 && z == 1) || (y == 1 and z == 1)
		
