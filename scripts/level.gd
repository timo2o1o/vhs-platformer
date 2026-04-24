extends Node2D

@export var reset_position: Vector2 = Vector2(320,300)
var last_checkpoint = null

var timer_node: Timer = null
var time_left: int = 30

@onready var hud: CanvasLayer = $HUD

@export var next_level : PackedScene = null

 # Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Exit.body_entered.connect(_on_exit_body_entered)
	timer_node = _instantiate_timer()
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _instantiate_timer() -> Timer:
	var new_timer: Timer = Timer.new()
	new_timer.wait_time = 1
		
	return new_timer
	
func _on_level_timer_timeout() -> void:
	time_left -= 1
	hud.set_time_left(time_left)
	
	if time_left <= 0:
		time_left = 30
		$player.reset(reset_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$player.reset(reset_position)

func _on_jump_pad_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$player.jump(2)

func _on_saw_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$player.reset(reset_position)

func _on_start_checkpoint_activated(cp_position: Vector2, checkpoint) -> void:
	reset_position = cp_position
	if last_checkpoint != null:
		last_checkpoint.deactivate()
	last_checkpoint = checkpoint

func _on_fruit_kiwi_fruit_collected(body: Node2D, sender: Variant) -> void:
	if body.name == "player":
		hud.increase_score(10)
		await sender.dispose()
		remove_child(sender)

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$player.active = false
		await $Exit.animate()
		
		if next_level != null:
			get_tree().change_scene_to_packed(next_level)
