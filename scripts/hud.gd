extends CanvasLayer

var current_score := 0.0

@onready var time_label := $"Timer-HUD/TimeLabel"
@onready var score_label: Label = $"Timer-HUD/ScoreLabel"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_time_left(time_left: int) -> void:
	time_label.text = "Time Left: {0}".format([time_left])
	
func increase_score(new_score: float) -> void:
	current_score += new_score
	
	score_label.text = "Score: {0}".format([current_score])
