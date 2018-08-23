extends Spatial

onready var FPS = get_node("Canvas/FPS")
onready var Bird = get_node("Bird")
onready var Camera = get_node("Camera")
onready var Energy_label = get_node("Canvas/Energy")
onready var Life_label = get_node("Canvas/Life")
onready var Cubes_label = get_node("Canvas/Cubes")
onready var Elements =  $Elements

var Cube = preload('res://Elements/Cube.tscn')
var Energy = preload('res://Elements/Energy.tscn')


func _ready():
	G.Main = self
	G.energy = 10000
	G.life = 10
	G.cubes = 0
	var Energy_ = null
	var Cube_ = null
	for i in range(100):
		Energy_ = Energy.instance()
		Energy_.set_translation(Vector3(
			rand_range(-800,800), rand_range(0, 800), rand_range(-800,800)
		))
		Elements.add_child(Energy_)
	for i in range(50):
		Cube_ = Cube.instance()
		Cube_.set_translation(Vector3(
			rand_range(-700,700), rand_range(0, 700), rand_range(-700,700)
		))
		Elements.add_child(Cube_)
	set_process(true)

func _process(delta):
	FPS.set_text(str(int(1.0/delta)))
#	Camera.set_transform(
#		Bird.transform.translated(Vector3(0,0.6,3)).looking_at(
#		Bird.get_translation(), Vector3(0,1,0))
#	)
	Camera.set_transform(
		Bird.transform.translated(
			Vector3(0,2.5-Bird.speed/25,Bird.speed/8+2)
		).looking_at(
			Bird.get_translation(), Vector3(0,1,0))
	)
