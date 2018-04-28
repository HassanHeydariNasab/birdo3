extends Spatial

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed('ui_up'):
		$B.translate(Vector3(0,0.1,0))
	if Input.is_action_pressed('ui_down'):
		$B.translate(Vector3(0,-0.1,0))
	if Input.is_action_pressed('ui_left'):
		$B.translate(Vector3(-0.1,0,0))
	if Input.is_action_pressed('ui_right'):
		$B.translate(Vector3(0.1,0,0))
	if Input.is_action_pressed('ui_page_down'):
		$B.translate(Vector3(0,0,0.1))
	if Input.is_action_pressed('ui_page_up'):
		$B.translate(Vector3(0,0,-0.1))
	$A.look_at($B.get_global_transform().origin, Vector3(-1,0,0))