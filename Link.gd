extends Node2D

onready var Joint = preload("Joint.gd")
var font = DynamicFont.new()
var a = null
var b = null
var constraint_a = Vector2()
var constraint_b = Vector2()
var length = 0

var constraint_force = 0.14
var constraint_precision = 0.1
 
	
func _init(joint_a, joint_b):
	a = joint_a
	b = joint_b
	length = Vector2(b.position.x - a.position.x, b.position.y - a.position.y).length()
#	a.connect('update_constraint', self, 'on_update_constraint')
#	b.connect('update_constraint', self, 'on_update_constraint')

func link_must_be_constraint():
	var actual_length = Vector2(b.target_position.x - a.target_position.x, b.target_position.y - a.target_position.y).length()
	return abs(actual_length - length) > length * constraint_precision

func update_constraint(inverse):
	var actual_length = Vector2(b.target_position.x - a.target_position.x, b.target_position.y - a.target_position.y).length()
	
	if (inverse):
		if actual_length - length > length * constraint_precision:
			constraint_a = (b.target_position - a.target_position) * constraint_force
			#a.set_target_position(a.target_position + constraint )
		
		if actual_length - length < -length * constraint_precision:
			constraint_a = -(b.target_position - a.target_position) * constraint_force
			#a.set_target_position(a.target_position + constraint)
	else:
		if actual_length - length > length * constraint_precision:
			constraint_b = -(b.target_position - a.target_position)* constraint_force
			#b.set_target_position(b.target_position + constraint)
			
		if actual_length - length < -length * constraint_precision:
			constraint_b = (b.target_position - a.target_position)* constraint_force
			#b.set_target_position(b.target_position + constraint)
			
func apply_constraint():
	a.set_target_position(a.target_position + constraint_a)
	b.set_target_position(b.target_position + constraint_b)
	constraint_a = Vector2()
	constraint_b = Vector2()
	
	
"""
func update_constraint(source_joint, joint, width_stack, joint_stack):
	var actual_length = Vector2(b.target_position.x - a.target_position.x, b.target_position.y - a.target_position.y).length()
	var stack_index = width_stack.find(self)
	var stack_index2 = width_stack.find_last(self)
	var passed_a    = (stack_index >=0 && joint_stack[stack_index] == a) || (stack_index2 >=0 && joint_stack[stack_index2] == a)
	var passed_b    = (stack_index >=0 && joint_stack[stack_index] == b) || (stack_index2 >=0 && joint_stack[stack_index2] == b)
	
	print(stack_index)
		
	#if (a == joint && (stack_index >=0 && joint_stack[stack_index] == a || stack_index == -1) && (stack_index2 >=0 && joint_stack[stack_index2] == a || stack_index2 == -1)):
	if (a == joint && !passed_b):
		if (b == source_joint):
			return
		if actual_length - length > length * constraint_force:
			var constraint = b.target_position - a.target_position
			b.set_target_position(b.target_position - constraint * constraint_force)
			
		if actual_length - length < -length * constraint_force:
			var constraint = b.target_position - a.target_position
			b.set_target_position(b.target_position + constraint * constraint_force)
		width_stack.append(self)
		joint_stack.append(b)
		b.trigger_update_constraint(a, width_stack, joint_stack)
		
	
	
	#if (b == joint && (stack_index >=0 && joint_stack[stack_index] == b || stack_index == -1) && (stack_index2 >=0 && joint_stack[stack_index2] == b || stack_index2 == -1)):
	if (b == joint && !passed_a):
		if (a == source_joint):
			return
		if actual_length - length > length * constraint_force:
			var constraint = b.target_position - a.target_position
			a.set_target_position(a.target_position + constraint * constraint_force)
		
		if actual_length - length < -length * constraint_force:
			var constraint = b.target_position - a.target_position
			a.set_target_position(a.target_position - constraint * constraint_force)
		width_stack.append(self)
		joint_stack.append(a)
		a.trigger_update_constraint(b, width_stack, joint_stack)
"""		


#func on_update_constraint(source_joint, joint, width_stack, joint_stack):
#	update_constraint(source_joint, joint, width_stack, joint_stack)
	
func _draw():
	var color = Color(0.5, 0.5, 0.5)
	var delta = b.position - a.position 
	draw_line(a.position, b.position, color)
	draw_string (font, a.position + (delta) / 2,round(delta.length()) as String)

func _ready():
	font.font_data = load("res://arial.ttf")
	pass
