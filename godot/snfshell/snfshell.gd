extends Node

@onready var text_edit: TextEdit = $TextEdit
@onready var r_output: RichTextLabel = $rOutput

var input_buffer : String = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func execute(cmd: Array) -> int:
	# TODO call & return the main function.
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
			execute(argv.slice(1))
		else: r_output.text += '/snf/> '
		# Clear the buffer.
		input_buffer = ''
