extends Node

@onready var text_edit: TextEdit = $TextEdit
@onready var r_output: RichTextLabel = $rOutput

var input_buffer : String = ''
var path : String = './'
var loader := preload("res://loader/Loader.cs").new()
var app_base := preload("res://loader/app_base.tscn")
var runtime : Dictionary = {}

func gename(length: int) -> String:
	var rng = RandomNumberGenerator.new()
	var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	var random_string = ""
	for i in range(length):
		random_string += charset[rng.randi_range(0, charset.length() - 1)]
	return random_string


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func execute(cmd: Array) -> int:
	var loaded : Array = loader.GetProgramsInDir(path)
	
	if not loaded.find(loaded) == -1:
		r_output.text += '\n[color=red]snfsh: not found:\t' + cmd[0] + '[/color]'
	else:
		var node = app_base.instantiate()
		node.name = cmd[0]+'@'+gename(8)
		runtime[node.name] = node
		add_child(node)
		# Load the program
		loader.LoadProgramFile(node.script, cmd[0])
		node.script.reload(true)
		node.main(cmd.slice(1))
	return 0;

func _on_text_edit_text_changed() -> void:
	r_output.text += text_edit.text; # Prints the word.
	input_buffer += text_edit.text;  # Save the word.
	text_edit.text = "";             # Cleat the word from the input.

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("del"):
		if r_output.text.length() > 0:  # Check if we can delete some text.
			r_output.text = r_output.text.left(r_output.text.length() - 1)
	if Input.is_action_pressed("ui_text_newline"):
		if not input_buffer.strip_edges().is_empty():
			var argv = input_buffer.strip_edges().split(' ', false)
			execute(argv)
		r_output.text += '\n@snf:' + path
		
		# Clear the buffer.
		input_buffer = ''
