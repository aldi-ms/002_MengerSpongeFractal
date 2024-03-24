@tool
extends MeshInstance3D

@export var update = false

func _ready():
	gen_mesh()
	
func gen_mesh():
	var array_mesh := ArrayMesh.new()
	var vertices := PackedVector3Array([
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(1,0,1),
		Vector3(0,0,1),
		
		Vector3(0,1,0),
		Vector3(1,1,0),
		Vector3(1,1,1),
		Vector3(0,1,1)
	])
	var indices := PackedInt32Array([
		0, 2, 1,
		0, 3, 2,
		
		5, 6, 4,
		4, 6, 7,
		
		0, 4, 3,
		3, 4, 7,
		
		3, 7, 2,
		2, 7, 6,
		
		1, 2, 6,
		6, 5, 1,
		
		0, 1, 5,
		5, 4, 0
	])
	
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices
	
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	mesh = array_mesh
	
func _process(delta):
	if update:
		gen_mesh()
		update = false
		
	rotate(Vector3(0.1,0.1,0.1).normalized(), 0.01)
