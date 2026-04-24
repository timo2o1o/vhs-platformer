extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal fruit_collected(body: Node2D, sender)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func dispose() -> void:
	animated_sprite_2d.play("collected")
	await animated_sprite_2d.animation_finished

func _on_body_entered(body: Node2D) -> void:
	fruit_collected.emit(body, self)
