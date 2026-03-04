class_name EssentialWoodBehaviour extends CanvasLayer

@export var essential_wood_list : Array[WoodBehaviour] = []
@export var player : CandlePlayer
@onready var fire = player.get_node("FireArea")
var cant_finish_text : String = "[color=red][wave]" + tr("NO-WAY-TO-FINISH")
var loosed : bool = false

func _ready() -> void:
	$RichTextLabel.text = cant_finish_text
	$RichTextLabel.visible = false

func _count_essential_wood() -> int:
	var count : int = 0
	for wood in essential_wood_list:
		if is_instance_valid(wood) and wood.is_inside_tree():
			count += 1
	return count

func _process(_delta: float) -> void:
	if _count_essential_wood() == 0 and not loosed:
		loosed = true
		$RichTextLabel.visible = true
		fire.kill()
