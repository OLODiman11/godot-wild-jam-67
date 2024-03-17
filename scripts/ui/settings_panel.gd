extends Panel

@export var master_bus_name: String
@export var sfx_bus_name: String
@export var music_bus_name: String

var _master_bus_index: int
var _sfx_bus_index: int
var _music_bus_index: int

@onready var master_slider = $VBoxContainer/SoundSettings/MasterSlider
@onready var sfx_slider = $VBoxContainer/SoundSettings/SFXSlider
@onready var music_slider = $VBoxContainer/SoundSettings/MusicSlider

func _ready():
	_master_bus_index = AudioServer.get_bus_index(master_bus_name)
	_sfx_bus_index = AudioServer.get_bus_index(sfx_bus_name)
	_music_bus_index = AudioServer.get_bus_index(music_bus_name)
	
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(_master_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(_sfx_bus_index))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(_music_bus_index))
	
	master_slider.value_changed.connect(set_volume.bind(_master_bus_index))
	sfx_slider.value_changed.connect(set_volume.bind(_sfx_bus_index))
	music_slider.value_changed.connect(set_volume.bind(_music_bus_index))
	
func set_volume( value: float, bus_index: int):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
