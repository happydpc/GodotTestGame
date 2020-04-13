extends Spatial

export (float) var Time_Of_Day = Globals.Time_Of_Day setget _on_Time_Of_Day_value_changed

var base_night_sky_rotation = Basis(Vector3(1.0, 1.0, 1.0).normalized(), 1.2)
var horizontal_angle = 25.0
var is_ready = false

func _set_sky_rotation():
	var rot = Basis(Vector3(0.0, 1.0, 0.0), deg2rad(horizontal_angle)) * Basis(Vector3(1.0, 0.0, 0.0), Time_Of_Day * PI / 12.0)
	rot = rot * base_night_sky_rotation;
	$Sky.set_rotate_night_sky(rot)

func _ready():
	# init our time of day
	$Sky.set_time_of_day(Time_Of_Day, get_node("Sun"), deg2rad(horizontal_angle))
	
	# rotate our night sky so our milkyway isn't on our horizon
	_set_sky_rotation()
	is_ready = true

func _on_Sky_texture_sky_updated():
	$Sky.copy_to_environment(get_node("World").environment)

func _on_Time_Of_Day_value_changed(value):
	# we cannot access child nodes until _ready is called
	if is_ready:
		$Sky.set_time_of_day(value, get_node("Sun"), deg2rad(horizontal_angle))
		_set_sky_rotation()
