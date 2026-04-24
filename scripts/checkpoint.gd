extends Area2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var animated_sprite_2d := $AnimatedSprite2D

signal checkpoint_activated(cp_position: Vector2, checkpoint)
var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func deactivate() -> void:
	animated_sprite_2d.play("idle")
	active = false

func _on_body_entered(body: Node2D) -> void:
	if !active:
		animated_sprite_2d.play("active")
		active = true

		checkpoint_activated.emit(marker_2d.global_position, self)
