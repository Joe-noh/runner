extends 'res://addons/gut/test.gd'

var runner
var bird

func before_each():
	runner = autofree(load('res://src/objects/runner/runner.tscn').instance())

	bird = autofree(Node.new())
	bird.add_to_group('birds')

func test_emit_killed():
	watch_signals(runner)

	runner._on_body_entered(bird)
	assert_signal_emitted(runner, 'killed')

func test_jump_with_ui_accept():
	watch_signals(runner)

	Input.action_press('ui_accept')
	simulate(runner, 1, 0.01)
	Input.action_release('ui_accept')

	assert_signal_emitted(runner, 'jump')

func test_dont_jump_after_death():
	watch_signals(runner)

	runner._on_body_entered(bird)

	Input.action_press('ui_accept')
	simulate(runner, 1, 0.01)
	Input.action_release('ui_accept')

	assert_signal_not_emitted(runner, 'jump')
