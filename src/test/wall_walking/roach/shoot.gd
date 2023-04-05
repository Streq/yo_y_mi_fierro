extends FighterState

onready var duration: Timer = $duration
onready var shoot_lag: Timer = $shoot_lag
onready var dung_shooter: Node2D = $"%dung_shooter"

func _ready():
	duration.connect("timeout",self,"timeout")
	shoot_lag.connect("timeout",self,"shoot")
var timeout = false
var shoot = false
func timeout():
	timeout = true
func _enter(params):
	timeout = false
	duration.start()
	shoot_lag.start()

func _physics_update(delta):
	
	
	var local_velocity = root.velocity.rotated(-root.global_rotation)
	local_velocity.x = 0.0
	root.velocity = local_velocity.rotated(root.global_rotation)
	
	if shoot:
		shoot = false
		dung_shooter.shoot()
	
	if timeout:
		goto("idle")
		return
	
	

func _move(delta):
	root.velocity += root.gravity.rotated(root.global_rotation)*delta
	root.velocity = root.move_and_slide(root.velocity, root.get_floor_normal())
	
func _pos_move(delta):
	pass
	
func shoot():
	shoot = true
