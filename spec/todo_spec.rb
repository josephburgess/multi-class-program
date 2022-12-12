require 'todo'

RSpec.describe Todo do
  task_1 = 'Walk the dog.'

  it 'initializes and accepts a task' do
    todo_1 = Todo.new(task_1)
  end

  it 'can return the task, walk the dog, as a string' do
    todo_1 = Todo.new(task_1)
    expect(todo_1.task).to eq 'Walk the dog.'
  end

  it 'will initially mark a task as not done / false when initializing' do
    todo_1 = Todo.new(task_1)
    expect(todo_1.done?).to eq false
  end

  it 'will mark a task as done using boolean values - true representing a completed task' do
    todo_1 = Todo.new(task_1)
    todo_1.mark_done
    expect(todo_1.done?).to eq true
  end
end
