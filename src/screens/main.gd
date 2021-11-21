extends Node2D

var _elapsed = 0
var _spawned = 0
var _rng = RandomNumberGenerator.new()

onready var Bird = load("res://src/objects/bird/bird.tscn")

func _ready():
	_rng.randomize()

	$Restart.hide()
	$Restart.connect('clicked', self, '_on_restart_clicked')

	$Runner.connect('killed', self, '_on_runner_killed')

func _process(delta):
	_elapsed += (10 + _spawned * 0.1) * delta

	if _elapsed > 10:
		var bird = Bird.instance()
		var y = _rng.randi_range(10, 760)
		bird.init(Vector2(1300, y), 2.0)
		bird.add_to_group('birds')

		add_child(bird)

		_spawned += 1
		_elapsed = 0

func _on_restart_clicked():
	if GameState.is_game_over:
		$Restart.hide()
		GameState.restart()
		get_tree().reload_current_scene()

func _on_runner_killed():
	GameState.game_over()
	$Restart.show()
