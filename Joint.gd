extends Node2D
signal update_constraint(joint, source_joint)

export var pinned   = false setget set_pinned
export var target_position = Vector2() setget set_target_position

var size = 10

func _init(initial_position):
	print('init')
	position = initial_position
	target_position = initial_position	
	
func set_pinned(val):
	pinned = val	
	update()

func set_position(val):
	position = val

func set_target_position(val):
	target_position = val
	
func update_position():
	var delta_position = target_position - position
			
	if delta_position.length() < 0.5:
		position = target_position
		pinned = false;
		update()
		return false
	
	position = position + delta_position * 0.1
	update()
	return true

func trigger_update_constraint(source_joint):
	emit_signal('update_constraint', source_joint, self)

func _input_event(viewport, event, shape_idx):
	print(event)
	if event is InputEventMouseButton:
		print('ccc')


#func _input(event):
#	print(event)
	#if event.type == InputEvent.MOUSE_BUTTON \
	#and event.button_index == BUTTON_LEFT \
	#and event.pressed:
	#	print("Clicked")

	
func _draw():
	var color = Color(1,0,0) if pinned else Color(1,1,1) 
	var delta_position = target_position - position
	draw_circle(Vector2(0,0), size, color)
	draw_circle(delta_position, size / 4, Color(0,1,0))


