extends Node

onready var Main = null

var energy = 0 setget set_energy, get_energy
func set_energy(value):
	energy = value
	Main.Energy.set_text(str(value))
func get_energy():
	return energy

func _init():
	pass