class_name StateMachine extends Node

@onready var controlled_node = self.owner

@export var default_state: StateBase

var current_state: StateBase = null

func _ready() -> void:
	call_deferred("_state_default_start")

#region Métodos de cambio de estado
func _state_default_start() -> void:
	current_state = default_state
	_state_start()

func _state_start() -> void: # Prepara variables para el nuevo estado y lanza su start()
	prints("StateMachine", controlled_node.name, "start state", current_state.name)
	
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()

func change_to(new_state: String) -> void:
	# Controlamos si ya hay un estado corriendo y lo termina
	if current_state and current_state.has_method("end"): current_state.end()
	current_state = get_node(new_state)
	_state_start()
#endregion

#region Métodos automáticos
# Activamos los comportamientos recurrentes dependiendo del estado actual
# A cada estado, hay que crear el método que se quiera usar (para evitar crearlos al pedo si no se usan)
func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)

func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)

func _input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)

func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)

func _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)
#endregion
