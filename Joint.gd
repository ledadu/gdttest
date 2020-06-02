extends Node2D

signal update_constraint(joint, source_joint, width_stack, joint_stack)
signal input_event(event, source_joint)

export var follow          = false setget set_follow
export var pinned          = false setget set_pinned
export var mouse_pressed   = false
export var target_position = Vector2() setget set_target_position

var size = 10

func _init(initial_position):
	position = initial_position
	target_position = initial_position	
	
func _ready():
	var joint_area =Area2D.new()
	var colision_shape = CollisionShape2D.new()
	var rectangle_shape = RectangleShape2D.new()
	rectangle_shape.extents = Vector2(10, 10)
	
	colision_shape.set_shape(rectangle_shape)
	
	joint_area.add_child(colision_shape)
	
	add_child(joint_area)
	joint_area.connect('input_event', self, '_input_event')

		
func set_follow(val):
	follow = val	
	update()

func set_pinned(val):
	pinned = val	
	update()

func set_position(val):
	position = val

func set_target_position(val):
	if !pinned:
		target_position = val
	
func update_position():
	var delta_position = target_position - position
			
	if delta_position.length() < 0.5:
		position = target_position
		return false
	
	position = position + delta_position * 0.1
	update()
	return true

func trigger_update_constraint(source_joint, width_stack, joint_stack):
	emit_signal('update_constraint', source_joint, self, width_stack, joint_stack)

func _input_event(viewport, event, shape_idx):	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			follow = follow || event.pressed
		if event.pressed:			
			if event.button_index == BUTTON_RIGHT:
				pinned = !pinned
		update()
		#emit_signal('input_event', event, self)

	
func _draw():
	var color = Color(1,1,1)
	if follow:
		color = Color(0,0,1) 
	if pinned:
		color = Color(1,0,0) 
	var delta_position = target_position - position
	draw_circle(Vector2(0,0), size, color)
	draw_circle(delta_position, size / 4, Color(0,1,0))


