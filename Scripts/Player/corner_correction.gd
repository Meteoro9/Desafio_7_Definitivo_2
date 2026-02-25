class_name CornerCorrection extends Node2D

@onready var raycast_left = $RayCast_left
@onready var raycast_right = $RayCast_right

@onready var player = self.owner
@export var correction : int

var left_raycast_collide : Object
var right_raycast_collide : Object

func _physics_process(_delta: float) -> void:
	left()
	right()

func left() -> void:
	if raycast_left.is_colliding() and !raycast_right.is_colliding():
		left_raycast_collide = raycast_left.get_collider()
		if left_raycast_collide.is_in_group("Enviroment"):
			player.position.x += correction
			print("Se corrigió la posición")

func right() -> void:
	if raycast_right.is_colliding() and !raycast_left.is_colliding():
		right_raycast_collide = raycast_right.get_collider()
		if right_raycast_collide.is_in_group("Enviroment"):
			player.position.x -= correction
