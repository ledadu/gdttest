extends Polygon2D
tool

export var start = Vector3() setget set_start
export var end = Vector3() setget set_end

export(Texture) var inputTexture setget set_texture

func set_start(val):
	start = val
	updatePolygon()
	updateUv()

func set_end(val):
	end = val
	updatePolygon()
	updateUv()
	
func set_texture(val):
	inputTexture = val
	texture = val
	updatePolygon()
	updateUv()

func updatePolygon():
	var median = [start - Vector3(start.z / 2, 0, 0), end - Vector3(start.z / 2, 0, 0)]
	
	var polygon = PoolVector2Array()
	polygon.append(Vector2(median[0].x - median[0].z / 2 + median[0].z / 2, median[0].y))
	polygon.append(Vector2(median[0].x + median[0].z / 2 + median[0].z / 2, median[0].y))

	polygon.append(Vector2(median[1].x + median[1].z / 2 + median[0].z / 2, median[1].y))
	polygon.append(Vector2(median[1].x - median[1].z / 2 + median[0].z / 2, median[1].y))

	set_polygon(polygon)
	
	var material = get_material()
	material.set_shader_param("widthU", median[0].z)
	material.set_shader_param("widthD", median[1].z)
	material.set_shader_param("height", median[1].y)
	
	material.set_shader_param("inputTexture", inputTexture)
	
func updateUv():
	var textureSize = get_texture().get_size()
	
	var uv = PoolVector2Array()

	uv.append(Vector2(0, 0))
	uv.append(Vector2(textureSize.x, 0))

	uv.append(Vector2(textureSize.x, textureSize.y))
	uv.append(Vector2(0, textureSize.y))
	set_uv(uv)
	


