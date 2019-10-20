extends Polygon2D
tool


export var startWidth = 10 setget set_start_width
export var endWidth = 10 setget set_end_width
export var end = Vector2() setget set_end

export(Texture) var inputTexture setget set_texture

func set_start_width(val):
	startWidth = val
	updatePolygon()
	updateUv()

func set_end(val):
	end = val
	updatePolygon()
	updateUv()

func set_end_width(val):
	endWidth = val
	updatePolygon()
	updateUv()

func set_texture(val):
	inputTexture = val
	texture = val
	updatePolygon()
	updateUv()

func updatePolygon():
	var median = [Vector2(-startWidth / 2, 0), Vector2(end.x - startWidth / 2, end.y)]
	
	var polygon = PoolVector2Array()
	polygon.append(Vector2(median[0].x - startWidth / 2 + startWidth / 2, median[0].y))
	polygon.append(Vector2(median[0].x + startWidth / 2 + startWidth / 2, median[0].y))

	polygon.append(Vector2(median[1].x + endWidth / 2 + startWidth / 2, median[1].y))
	polygon.append(Vector2(median[1].x - endWidth / 2 + startWidth / 2, median[1].y))

	set_polygon(polygon)
	
	var material = get_material()
	material.set_shader_param("widthU", startWidth)
	material.set_shader_param("widthD", endWidth)
	material.set_shader_param("height", median[1].y)
	material.set_shader_param("downOffset", end.x)
	
	material.set_shader_param("inputTexture", inputTexture)
	
func updateUv():
	var textureSize = get_texture().get_size()
	
	var uv = PoolVector2Array()

	uv.append(Vector2(0, 0))
	uv.append(Vector2(textureSize.x, 0))

	uv.append(Vector2(textureSize.x, textureSize.y))
	uv.append(Vector2(0, textureSize.y))
	set_uv(uv)
	


