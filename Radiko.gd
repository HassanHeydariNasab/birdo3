extends Spatial

onready var FPS = get_node("Kanvaso/FPS")
onready var Birdo = get_node("Birdo")

func _ready():
	set_process(true)

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))