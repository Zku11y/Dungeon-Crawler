extends Node2D

@export var node: Node2D
#@onready var sprite: Sprite2D = $Body/sprite
#@onready var body: StaticBody2D = $Body
#@onready var area: Area2D = $Body/Collection_area
@onready var player: CharacterBody2D = $"../../Player"


var points := 0


func _on_collection_area_body_entered(body: Node2D) -> void:
	player.orbs += 1
	queue_free()
