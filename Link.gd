extends Node2D

onready var Joint = preload("Joint.gd")
var font = DynamicFont.new()
var a = null
var b = null
var length = 0

var elasticity = 0.5
 
	
func _init(joint_a, joint_b):
	a = joint_a
	b = joint_b
	length = Vector2(b.position.x - a.position.x, b.position.y - a.position.y).length()
	a.connect('update_constraint', self, 'on_update_constraint')
	b.connect('update_constraint', self, 'on_update_constraint')

func update_constraint(source_joint, joint):
	var actual_length = Vector2(b.target_position.x - a.target_position.x, b.target_position.y - a.target_position.y).length()
		
	if (a == joint):
		if (b == source_joint):
			return
		if actual_length - length > 0.5:
			var constraint = b.target_position - a.target_position
			b.set_target_position(b.target_position - constraint * 0.1)
			
		if actual_length - length < -0.5:
			var constraint = b.target_position - a.target_position
			b.set_target_position(b.target_position + constraint * 0.1)
			
		b.trigger_update_constraint(a)
		
	
	
	if (b == joint):
		if (a == source_joint):
			return
		if actual_length - length > 0.5:
			var constraint = b.target_position - a.target_position
			a.set_target_position(a.target_position + constraint * 0.1)
		
		if actual_length - length < -0.5:
			var constraint = b.target_position - a.target_position
			a.set_target_position(a.target_position - constraint * 0.1)
			
		a.trigger_update_constraint(b)
		


func on_update_constraint(source_joint, joint):
	update_constraint(source_joint, joint)
	
func _draw():
	var color = Color(0.5, 0.5, 0.5)
	var delta = b.position - a.position 
	draw_line(a.position, b.position, color)
	draw_string (font, a.position + (delta) / 2,round(delta.length()) as String)

func _ready():
	font.font_data = load("res://arial.ttf")
	pass
