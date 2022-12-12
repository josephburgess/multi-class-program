require 'todo_list'

RSpec.describe TodoList do

  it 'initializes with an empty array for the todos to be added to' do
    todolist = TodoList.new
    expect(todolist.instance_variable_get(:@list)).to eq []
  end

  it 'raises an error if no todos have been passed to it' do
    todolist = TodoList.new
    expect { todolist.all }.to raise_error 'There are no tasks on the list currently.'
  end

  it 'confirms that there are no pending tasks if requesting a list of incomplete tasks when there are none' do
    todolist = TodoList.new
    expect(todolist.incomplete).to eq 'There are no pending tasks!'
  end

  it 'informs the user they have not yet completed any tasks if requesting a list of completed tasks when there are none' do
    todolist = TodoList.new
    expect(todolist.complete).to eq "You've not done any tasks yet!"
  end

  it 'will raise an error if trying to mark_all_done when there are no tasks' do
    todolist = TodoList.new
    expect { todolist.mark_all_done }.to raise_error 'There are no pending tasks!'
  end
end