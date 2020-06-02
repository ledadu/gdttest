extends Node2D

var mouse_pressed = false

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

func draw_links():
	for link in links:
		link.update()

func update_active_Joints():
	var oneIsPined = false
	
	for joint in joints:
		if joint.pinned:
			oneIsPined = true
			joint.trigger_update_constraint(null)
			
	if !oneIsPined:
		joints[1].trigger_update_constraint(null)
	
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		mouse_pressed = event.pressed
		
	if mouse_pressed:
		joints[1].set_pinned(true)
		joints[1].set_target_position(event.position)
	
	#if event.type == InputEvent.MOUSE_BUTTON:
	#	if event.button_index == BUTTON_LEFT and event.pressed:

func _process(delta):
	update_active_Joints()
	
	update_joints_position()
	
	draw_links()
	
	# trigger draw
	#update()

