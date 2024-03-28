extends MeshInstance3D

@export var update = false

func gen_mesh(pos: Vector3, side: float):
	var array_mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var indices := PackedInt32Array()
	var uvs := PackedVector2Array()
	var normals := PackedVector3Array()

	var cube_vertices = [
		pos, #Vector3(0, 0, 0)
		pos + Vector3(side, 0, 0),
		pos + Vector3(side, 0, side),
		pos + Vector3(0, 0, side),
		
		pos + Vector3(0, side, 0),
		pos + Vector3(side, side, 0),
		pos + Vector3(side, side, side),
		pos + Vector3(0, side, side)
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
	if update || Input.is_key_pressed(KEY_SPACE):
		#gen_mesh(Vector3.ZERO, 1)
		update = false
		
	rotate(Vector3(0.1,0.1,0.1).normalized(), 0.01)

func _on_menger_sponge_generate_mesh(pos, side):
	print("sponge called: position:%s, size:%s" % [pos, side])
	gen_mesh(pos, side)
