extends ParallaxBackground

var scroll_speed = 15

@onready var sprite :Sprite2D = $ParallaxLayer/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	if sprite.region_rect.position >= Vector2(64,64):
		sprite.region_rect.position = Vector2(0,0)
	
	pass
