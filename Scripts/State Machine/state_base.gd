class_name StateBase extends Node

@onready var controlled_node = self.owner

var state_machine: StateMachine = get_parent()

func start(): pass
func end(): pass
