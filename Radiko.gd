extends Spatial

onready var FPS = get_node("Kanvaso/FPS")
onready var Birdo = get_node("Birdo")
onready var Kamero = get_node("Kamero")

func _ready():
	set_process(true)

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))
#	Kamero.set_transform(
#		Birdo.transform.translated(Vector3(0,0.6,3)).looking_at(
#		Birdo.get_translation(), Vector3(0,1,0))
#	)
	Kamero.set_transform(
		Birdo.transform.translated(
			Vector3(0,1.3-Birdo.rapido/25,Birdo.rapido/8+2)
		).looking_at(
			Birdo.get_translation(), Vector3(0,1,0))
	)
