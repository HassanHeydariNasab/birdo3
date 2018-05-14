extends Node

onready var Main = null

var energy = 0 setget set_energy, get_energy
func set_energy(value):
	energy = value
	Main.Energy.set_text(str(value))
func get_energy():
	return energy

var life = 0 setget set_life, get_life
func set_life(value):
	life = value
	Main.Life.set_text(str(value))
func get_life():
	return life

func _init():
	pass