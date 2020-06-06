extends Node2D

var mouse_position = Vector2(0,0)

onready var Joint = preload("Joint.gd")
onready var Link = preload("Link.gd")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var joints = []
var links = []
var links_to_process = [];
var joints_to_process = [];
var link_processed = [];

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
	links.append(Link.new(c, d))
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
		

func add_active_joints_to_process():
	joints_to_process = []
	for joint in joints:
		if joint.follow:
			joint.set_target_position(mouse_position)
		if joint.follow || joint.pinned:
			joints_to_process.append(joint)
			
func add_passive_links_to_process():
	for link in links:
		if link.link_must_be_constraint():
			joints_to_process.append(link.a)
			links_to_process.append({"link": link, "inverse": false})
		
func add_links_to_process():
	# TODO unique joints_to_process
	links_to_process = []
	for joint in joints_to_process:
		for link in links:
			if (!link_processed.has(link)):
				if (joint ==link.a):
					links_to_process.append({"link": link, "inverse": false})
				if (joint ==link.b):
					links_to_process.append({"link": link, "inverse": true})


func update_links_to_process():			
	#reset joints_to_process
	joints_to_process = []

	for link_to_process in links_to_process:
		link_to_process.link.update_constraint(link_to_process.inverse)
		link_processed.append(link_to_process.link)
		if (link_to_process.inverse):
			joints_to_process.append(link_to_process.link.a)
		else:
			joints_to_process.append(link_to_process.link.b)
	
	for link in links:
		link.apply_constraint()


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
	# first joint to process (active)
	add_active_joints_to_process()
	
	if (joints_to_process.size() == 0):
		add_passive_links_to_process()
	
	while(joints_to_process.size() > 0):
	#for i in range(10):
		# add links to process from joints_to_process and 
		add_links_to_process()
		
		#update links to process and set joints_to_process
		update_links_to_process()
	
	
	update_joints_position()
	link_processed = []
	
	#redrawn links
	for link in links:
		link.update()




