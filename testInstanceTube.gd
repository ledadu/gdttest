extends Node2D

onready var gridTexture = load("res://rect19.png")
#onready var gridTexture = load("res://grid.png")
#onready var gridTexture = load("res://rope_albedo.png")
#onready var gridTexture = load("res://rails.jpg")

onready var Tube = preload("TubeEl.gd")
onready var tube = Tube.new()
onready var tube2 = Tube.new()
onready var tube3 = Tube.new()
onready var tube4 = Tube.new()
onready var time = 0


func _ready():
	
	
	tube.transform.origin = Vector2(200, 100)
	tube.set_start_width(200)
	tube.set_end_width(200)
	tube.set_end_angle(-30)
	tube.set_end(Vector2(100, 200))
	tube.set_texture(gridTexture)
	add_child(tube)
	
	
	tube2.transform.origin = Vector2(300, 300)
	tube2.set_start_width(200)
	tube2.set_end_width(200)
	tube2.set_end(Vector2(0, 300))
	tube2.set_start_angle(-30)
	tube2.set_end_angle(-40)
	tube2.set_texture(gridTexture)
	add_child(tube2)
	
	tube3.transform.origin = Vector2(300, 600)
	tube3.set_start_width(200)
	tube3.set_end_width(200)
	tube3.set_end(Vector2(300, 0))
	tube3.set_start_angle(-40)
	tube3.set_end_angle(-90)
	tube3.set_texture(gridTexture)
	add_child(tube3)
	
	tube4.transform.origin = Vector2(600, 600)
	tube4.set_start_width(200)
	tube4.set_end_width(400)
	tube4.set_end(Vector2(300, -300))
	tube4.set_start_angle(-90)
	tube4.set_end_angle(-135)
	tube4.set_texture(gridTexture)
	add_child(tube4)
	
func _process(delta):
	update()
	
func _draw():	
		time = time + self.get_process_delta_time()
		var rand = randi()%4+1
		tube2.set_end_width(100 * (2 + sin(time)))
		tube3.set_start_width(100 * (2 + sin(time)))
		
		tube2.set_end_angle(-40 + -20 * (sin(time * 4)))
		tube3.set_start_angle(-40 + -20 * (sin(time * 4 )))
