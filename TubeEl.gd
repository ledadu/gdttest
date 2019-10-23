extends Polygon2D
tool
export var startWidth = 10 setget set_start_width
export var startAngle = 0 setget set_start_angle

export var end = Vector2() setget set_end
export var endWidth = 10 setget set_end_width
export var endAngle = 0 setget set_end_angle

export(Texture) var inputTexture setget set_texture

	
func updatePolygon():
	var median = [Vector2(-startWidth / 2, 0), Vector2(end.x - startWidth / 2, end.y)]
	
	var polygon = PoolVector2Array()
	
	var radStartAngle = deg2rad(startAngle - 180)
	var startRotateOffset = Vector2(cos(radStartAngle) * startWidth / 2, sin(radStartAngle) * startWidth / 2)
	
	polygon.append(startRotateOffset + Vector2(0, median[0].y))
	polygon.append(-startRotateOffset + Vector2(0, median[0].y))
	#polygon.append(Vector2(median[0].x - startWidth / 2 + startWidth / 2, median[0].y))
	#polygon.append(Vector2(median[0].x + startWidth / 2 + startWidth / 2, median[0].y))

	var radEndAngle = deg2rad(endAngle)
	var endRotateOffset = Vector2(cos(radEndAngle) * endWidth / 2, sin(radEndAngle) * endWidth / 2)
	
	polygon.append(endRotateOffset + Vector2(median[1].x + startWidth / 2, median[1].y))
	polygon.append(-endRotateOffset + Vector2(median[1].x + startWidth / 2, median[1].y))
	
	set_polygon(polygon)
	
	var material = get_material()
	material.set_shader_param("p0", polygon[0])
	material.set_shader_param("p1", polygon[1])
	material.set_shader_param("p2", polygon[2])
	material.set_shader_param("p3", polygon[3])
	
	material.set_shader_param("inputTexture", inputTexture)


func set_start_width(val):
	startWidth = val
	updatePolygon()
	
func set_end(val):
	end = val
	updatePolygon()
	
func set_end_width(val):
	endWidth = val
	updatePolygon()
	
func set_texture(val):
	inputTexture = val
	texture = val
	updatePolygon()
	
func set_end_angle(val):
	endAngle = val
	updatePolygon()
	
func set_start_angle(val):
	startAngle = val
	updatePolygon()

