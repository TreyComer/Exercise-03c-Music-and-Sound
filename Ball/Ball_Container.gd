extends Node2D

onready var Ball = load("res://Ball/Ball.tscn")
onready var Cdown = get_node("/root/Game/Starting/Countdown")
onready var timer = get_node("/root/Game/Starting/Timer")
var countdown = 10
var c = 0

func _ready():
	start_ball()

func start_ball():
	for ch in get_children():
		ch.queue_free()
	c = countdown
	Cdown.show()
	Cdown.text = "Starting in: " + str(c)
	timer.start()

func create_ball():
	var ball = Ball.instance()
	ball.position = Vector2(512, 650)
	ball.name = "Ball"
	ball.apply_central_impulse(Vector2(250,-250))
	add_child(ball)


func _on_Timer_timeout():
	c -= 1
	if c > 0:
		Cdown.text = "Starting in: " + str(c)
	else:
		Cdown.text = ""
		Cdown.hide()
		create_ball()
		timer.stop()

func _physics_process(_delta):
	for ch in get_children():
		ch.rect_position.x += (randf()-0.5)
		ch.rect_position.y += (randf()-0.5)
		
		ch.rect_size *= (1-shrink_amount)
		ch.color = ch.color.from_hsv(ch.color.h+hue_amount, ch.color.s-desaturate_amount, ch.color.v-darken_amount, ch.color.a-fade_amount)
		if ch.color.a <= 0:
			ch.queue_free()
