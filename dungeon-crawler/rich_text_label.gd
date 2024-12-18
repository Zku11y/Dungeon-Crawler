
extends RichTextLabel
#@onready var player: CharacterBody2D = $"../../Player"
var score_text = "score : "
@onready var timer: Timer = $"../../timer"
@onready var player: CharacterBody2D = $"../../Player"

var panic_time : int = 20
var time_left = 0
var rate : int = 0
var level : int = 0
var orbs_points : int = 0


func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
	time_left = timer.time_left
	print("time left = ", time_left)
	if player.orbs > orbs_points:
		var time_added = timer.time_left + 5
		timer.stop()
		timer.start(time_added)
		orbs_points = player.orbs
	if (time_left == 0):
		self.text = ("00")
		return
	if  time_left < panic_time:
		rate = panic_time - time_left
		level = panic_time - time_left
	#var current_score = str("[shake freq=0.01]" ,score_text, player.score, "[/shake]")
	var current_time : String
	if time_left < 10:
		current_time = str("[shake rate=%d" % rate, " level=%d" % level, "]", "0%d" % timer.time_left, "[/shake]")
	else:
		current_time = str("[shake rate=%d" % rate, " level=%d" % level, "]", "%d" % timer.time_left, "[/shake]")
	print("rate = ", rate, "level", level)
	self.text = (current_time)
