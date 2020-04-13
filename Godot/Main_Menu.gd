extends Control

# NOTE: The code here is only briefly explained in the tutorial, nor
#		does the code have very many comments!
#		This is because it does not really relate to making a FPS.

var start_menu
var options_menu

export (String, FILE) var testing_area_scene


func _ready():
	start_menu = $Start_Menu
	options_menu = $Options_Menu
	
	# Connect all of the start menu buttons
	var _err = $Start_Menu/Button_Start.connect("pressed", self, "start_menu_button_pressed", ["start"])
	_err = $Start_Menu/Button_Open_Godot.connect("pressed", self, "start_menu_button_pressed", ["open_godot"])
	_err = $Start_Menu/Button_Options.connect("pressed", self, "start_menu_button_pressed", ["options"])
	_err = $Start_Menu/Button_Quit.connect("pressed", self, "start_menu_button_pressed", ["quit"])
		
	# Connect all of the options menu buttons
	_err = $Options_Menu/Button_Back.connect("pressed", self, "options_menu_button_pressed", ["back"])
	_err = $Options_Menu/Button_Fullscreen.connect("pressed", self, "options_menu_button_pressed", ["fullscreen"])
	_err = $Options_Menu/Check_Button_VSync.connect("pressed", self, "options_menu_button_pressed", ["vsync"])
	_err = $Options_Menu/Check_Button_Debug.connect("pressed", self, "options_menu_button_pressed", ["debug"])
	
	# Some times when returning to the title screen the mouse is still captured even though it shouldn't be.
	# To prevent this from breaking the game, we just set it here too
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Get the globals singleton
	var globals = get_node("/root/Globals")
	# Get the mouse sensitivity
	$Options_Menu/HSlider_Mouse_Sensitivity.value = globals.mouse_sensitivity


func start_menu_button_pressed(button_name):
	if button_name == "start":
		set_mouse_sensitivity()
		get_node("/root/Globals").load_new_scene(testing_area_scene)
	elif button_name == "open_godot":
		var _err = OS.shell_open("https://godotengine.org/")
	elif button_name == "options":
		options_menu.visible = true
		start_menu.visible = false
	elif button_name == "quit":
		get_tree().quit()


func options_menu_button_pressed(button_name):
	if button_name == "back":
		start_menu.visible = true
		options_menu.visible = false
	elif button_name == "fullscreen":
		OS.window_fullscreen = !OS.window_fullscreen
	elif button_name == "vsync":
		OS.vsync_enabled = $Options_Menu/Check_Button_VSync.pressed
	elif button_name == "debug":
		get_node("/root/Globals").set_debug_display($Options_Menu/Check_Button_Debug.pressed)


func set_mouse_sensitivity():
	# Get the globals singleton
	var globals = get_node("/root/Globals")
	# Set the mouse sensitivity
	globals.mouse_sensitivity = $Options_Menu/HSlider_Mouse_Sensitivity.value
