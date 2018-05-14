extends Spatial

onready var FPS = get_node("Canvas/FPS")
onready var Bird = get_node("Bird")
onready var Camera = get_node("Camera")
onready var Energy = get_node("Canvas/Energy")
onready var Life = get_node("Canvas/Life")

func _ready():
	G.Main = self
	G.energy = 10000
	G.life = 10
	set_process(true)

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))
#	Camera.set_transform(
#		Bird.transform.translated(Vector3(0,0.6,3)).looking_at(
#		Bird.get_translation(), Vector3(0,1,0))
#	)
	Camera.set_transform(
		Bird.transform.translated(
			Vector3(0,1.3-Bird.speed/25,Bird.speed/8+2)
		).looking_at(
			Bird.get_translation(), Vector3(0,1,0))
	)
