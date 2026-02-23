class_name StateGravityBase extends StateBase

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

func handle_gravity(delta):
	controlled_node.velocity.y += gravity * delta
