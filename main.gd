extends Node2D

func _ready() -> void:
	print("O Node entrou na Scene Tree!")

func _process(delta: float) -> void:
	position.x += 100 * delta
