extends Node

onready var Main = null

var energy = 0 setget set_energy, get_energy
func set_energy(value):
	energy = value
	Main.Energy_label.set_text(str(value))
func get_energy():
	return energy

var life = 0 setget set_life, get_life
func set_life(value):
	life = value
	Main.Life_label.set_text(str(value))
func get_life():
	return life

var cubes = 0 setget set_cubes, get_cubes
func set_cubes(value):
	cubes = value
	Main.Cubes_label.set_text(str(value))
func get_cubes():
	return cubes

func _init():
	pass