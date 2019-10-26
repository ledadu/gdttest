extends Node2D

onready var gridTexture = load("res://grid.png")
onready var Tube = preload("TubeEl.gd")
func _ready():
	
	var tube = Tube.new()
	tube.transform.origin = Vector2(200, 100)
	tube.set_start_width(200)
	tube.set_end_width(200)
	tube.set_end_angle(-30)
	tube.set_end(Vector2(100, 200))
	tube.set_texture(gridTexture)
	add_child(tube)
	
	var tube2 = Tube.new()
	tube2.transform.origin = Vector2(300, 300)
	tube2.set_start_width(200)
	tube2.set_end_width(100)
	tube2.set_end(Vector2(0, 300))
	tube2.set_start_angle(-30)
	tube2.set_texture(gridTexture)
	add_child(tube2)
	
	