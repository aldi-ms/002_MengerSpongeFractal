@tool
extends MeshInstance3D

@export var update = false

func _ready():
	gen_mesh2()
	
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
	var uvs := PackedVector2Array([
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
	])
	
	var face_normals := PackedVector3Array()
	for i in range(0, indices.size(), 3):
		var a = vertices[indices[i]]
		var b = vertices[indices[i + 1]]
		var c = vertices[indices[i + 2]]
		var normal = (c - a).cross(b - a).normalized()
		face_normals.append(normal)
		
	var normals := PackedVector3Array()
	for i in range(vertices.size()):
		var normal_sum = Vector3.ZERO
		var face_count = 0
		for j in range(0, indices.size(), 3):
			if indices[j] == i || indices[j+1] == i || indices[j+2] == i:
				normal_sum += face_normals[floor(j / 3)]
				face_count += 1
		normals.append(normal_sum / 3)
	
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices
	array[Mesh.ARRAY_TEX_UV] = uvs
	array[Mesh.ARRAY_NORMAL] = normals
	
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	mesh = array_mesh
	
	#var surface_tool = SurfaceTool.new()
	#surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	#surface_tool.set_smooth_group(-1)
	#for i in range(vertices.size()):
		#surface_tool.set_uv(uvs[i])
		#surface_tool.add_vertex(vertices[i])
	#for i in indices:
		#surface_tool.add_index(i)
	#surface_tool.generate_normals()
	#surface_tool.generate_tangents()
	#array_mesh = surface_tool.commit()
	#mesh = array_mesh
	
func gen_mesh2():
	var array_mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()
	var uvs := PackedVector2Array()
	var normals := PackedVector3Array()

	var cube_uvs := PackedVector2Array([
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
	])
	var cube_vertices = [
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(1,0,1),
		Vector3(0,0,1),
		
		Vector3(0,1,0),
		Vector3(1,1,0),
		Vector3(1,1,1),
		Vector3(0,1,1)
	]
	var cube_faces = [
		[0, 2, 1],
		[0, 3, 2],
		
		[5, 6, 4],
		[4, 6, 7],
		
		[0, 4, 3],
		[3, 4, 7],
		
		[3, 7, 2],
		[2, 7, 6],
		
		[1, 2, 6],
		[6, 5, 1],
		
		[0, 1, 5],
		[5, 4, 0]
	]

	for face in cube_faces:
		var a = cube_vertices[face[0]]
		var b = cube_vertices[face[1]]
		var c = cube_vertices[face[2]]
		var normal = (c - a).cross(b - a).normalized()

		for vertex in face:
			vertices.append(cube_vertices[vertex])
			normals.append(normal)
			uvs.append(cube_uvs[vertex])
			indices.append(indices.size())

	var array = []
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices
	array[Mesh.ARRAY_TEX_UV] = uvs
	array[Mesh.ARRAY_NORMAL] = normals
	
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, array)
	mesh = array_mesh
	

func _process(delta):
	if update:
		gen_mesh2()
		update = false
		
	rotate(Vector3(0.1,0.1,0.1).normalized(), 0.01)
