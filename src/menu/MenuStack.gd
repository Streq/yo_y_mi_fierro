extends Node

signal empty()

var stack = []


func pop():
	var popped = stack.pop_back()
	popped.exit()
	if stack.empty():
		Pause.unpause(PauseState.Level.MENU)
		emit_signal("empty")
		return
	stack.back().enter()
	
func push(menu_state):
	if !stack.empty():
		stack.back().exit()
	stack.push_back(menu_state)
	stack.back().enter()
	Pause.pause(PauseState.Level.MENU)
	pass

func push_many(menu_states):
	if !menu_states:
		return
	if !stack.empty():
		stack.back().exit()
	stack.append_array(menu_states)
	stack.back().enter()
	Pause.pause(PauseState.Level.MENU)

func exit_current():
	if !stack.empty():
		stack.back().exit()

func current():
	return stack.back() if !stack.empty() else null

func empty():
	return stack.empty()
	
func clear():
	var is_empty = stack.empty()
	
	if !is_empty:
		stack.back().exit()
	
	stack.clear()
	
	if !is_empty:
		Pause.unpause(PauseState.Level.MENU)
		emit_signal("empty")
