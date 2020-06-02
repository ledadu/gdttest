extends Node2D

var mouse_position = Vector2(0,0)

onready var Joint = preload("Joint.gd")
onready var Link = preload("Link.gd")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var joints = []
var links = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var a = Joint.new(Vector2(100, 100))
	joints.append(a)
	var b = Joint.new(Vector2(100, 200))
	joints.append(b)
	var c = Joint.new(Vector2(200, 200))
	joints.append(c)
	var d = Joint.new(Vector2(100, 300))
	joints.append(d)
	
	links.append(Link.new(a, b))	
	links.append(Link.new(b, c))
	links.append(Link.new(b, d))
	"""
	a.connect('input_event', self, 'on_input_event')
	b.connect('input_event', self, 'on_input_event')
	c.connect('input_event', self, 'on_input_event')
	d.connect('input_event', self, 'on_input_event')
	"""
	for joint in joints:
		add_child(joint)
		
	for link in links:
		add_child(link)
	
	
		
func moveHead():
	var mousePosition = get_viewport().get_mouse_position()
	joints[0].set_target_position(mousePosition)

func update_joints_position():
	for joint in joints:
		joint.update_position()

func update_links():
	for link in links:
		link.update()

func update_active_Joints():
	var oneIsAttach = false	
			
	for joint in joints:
		if joint.follow:
			joint.set_target_position(mouse_position)
		if joint.follow || joint.pinned:
			oneIsAttach = true
			joint.trigger_update_constraint(null)
			
	if !oneIsAttach:
		joints[1].trigger_update_constraint(null)
"""
func on_input_event(event, joint):
	print('yoo')
	print(event)
	print(joint)
"""

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position	
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !event.pressed:
			for joint in joints:
				if joint.follow:
					joint.set_follow(false)
	pass

func _process(delta):
	update_active_Joints()
	
	update_joints_position()
	
	update_links()


