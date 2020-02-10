extends Spatial

# All of the audio files.
# You may want more realistic sounds, these are CC0.
var audio_pistol_shot = preload("res://assets/Arrow.wav")
var audio_gun_cock = preload("res://assets/Reload.wav")
var audio_rifle_shot = preload("res://assets/Explosion.wav")

var audio_node = null

func _ready():
	audio_node = $Audio_Stream_Player
	audio_node.connect("finished", self, "destroy_self")
	audio_node.stop()


func play_sound(sound_name, position=null):
	
	if audio_pistol_shot == null or audio_rifle_shot == null or audio_gun_cock == null:
		print ("Audio not set!")
		queue_free()
		return
	
	if sound_name == "pistol_shot":
		audio_node.set_volume_db(16)
		audio_node.stream = audio_pistol_shot
	elif sound_name == "rifle_shot":
		audio_node.set_volume_db(-4)
		audio_node.stream = audio_rifle_shot
	elif sound_name == "gun_cock":
		audio_node.set_volume_db(16)
		audio_node.stream = audio_gun_cock
	else:
		print ("UNKNOWN STREAM")
		queue_free()
		return

	# If you are using a AudioPlayer3D, then uncomment these lines to set the position.
	# if position != null:
	#       audio_node.global_transform.origin = position

	audio_node.play()


func destroy_self():
	audio_node.stop()
	queue_free()

