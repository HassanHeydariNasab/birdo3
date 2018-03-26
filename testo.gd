extends Spatial

onready var a = get_node("animation_player")

func _ready():
	a.play("anim")
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("flugi"):
		a.play("anim")