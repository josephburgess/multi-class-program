require 'contact_book'
require 'diary_entry'
require 'diary'
require 'todo_list'
require 'todo'

RSpec.describe 'diary entry integration spec' do
  contents1 = 'bananas ' * 100
  contents2 = 'bananas ' * 200
  contents3 = 'bananas ' * 300
  contents4 = 'bananas ' * 400

  it 'will add a new entry when passed a diary entry' do
    diary = Diary.new
    diary_entry = DiaryEntry.new('my_title', 'my_contents')
    diary.add(diary_entry)
    expect(diary.list).to eq [diary_entry]
  end

  it 'will return entries when requested' do
    diary = Diary.new
    diary_entry = DiaryEntry.new('my_title', 'my_contents')
    diary_entry2 = DiaryEntry.new('my_title2', 'my_contents2')
    diary.add(diary_entry)
    diary.add(diary_entry2)
    expect(diary.all).to eq "\n **#{diary_entry.title}** \n #{diary_entry.contents} \n **#{diary_entry2.title}** \n #{diary_entry2.contents} "
  end

  it 'will return the exact best entry when there is an exact match' do
    diary = Diary.new
    diary_entry1 = DiaryEntry.new('Title1', contents1)
    diary_entry2 = DiaryEntry.new('Title2', contents2)
    diary_entry3 = DiaryEntry.new('Title3', contents3)
    diary_entry4 = DiaryEntry.new('Title4', contents4)
    diary.add(diary_entry1)
    diary.add(diary_entry2)
    diary.add(diary_entry3)
    diary.add(diary_entry4)
    expect(diary.best_entry_for_reading_time(300, 1)).to eq diary_entry3.contents
  end

  it 'will return the best entry when there is not an exact match' do
    diary = Diary.new
    diary_entry1 = DiaryEntry.new('Title1', contents1)
    diary_entry2 = DiaryEntry.new('Title2', contents2)
    diary_entry3 = DiaryEntry.new('Title3', contents3)
    diary_entry4 = DiaryEntry.new('Title4', contents4)
    diary.add(diary_entry1)
    diary.add(diary_entry2)
    diary.add(diary_entry3)
    diary.add(diary_entry4)
    expect(diary.best_entry_for_reading_time(270, 1)).to eq diary_entry2.contents
  end

  it 'will return an error if there is not a short enough entry the user can read' do
    diary = Diary.new
    diary_entry3 = DiaryEntry.new('Title3', contents3)
    diary_entry4 = DiaryEntry.new('Title4', contents4)
    diary.add(diary_entry3)
    diary.add(diary_entry4)
    expect { diary.best_entry_for_reading_time(100, 1) }.to raise_error 'There are no entries you can read.'
  end

  it 'will return an error if the wpm is 0' do
    diary = Diary.new
    diary_entry3 = DiaryEntry.new('Title3', contents3)
    diary.add(diary_entry3)
    expect { diary.best_entry_for_reading_time(0, 1) }.to raise_error 'WPM must be more than zero.'
  end

  it 'will add todos to a todo list when passed a todo' do
    todolist = TodoList.new
    todo1 = Todo.new('Walk the dog.')
    todolist.add(todo1)
    expect(todolist.all).to eq [todo1]
  end

  it 'returns completed tasks when one is provided and marked done' do
    todolist = TodoList.new
    todo_1 = Todo.new('Walk the dog.')
    todo_2 = Todo.new('Mow the lawn.')
    todolist.add(todo_1)
    todolist.add(todo_2)
    todo_1.mark_done
    expect(todolist.complete).to eq [todo_1.task]
  end

  it 'returns incomplete tasks when calling the incomplete method' do
    todolist = TodoList.new
    todo_1 = Todo.new('Walk the dog.')
    todo_2 = Todo.new('Mow the lawn.')
    todolist.add(todo_1)
    todolist.add(todo_2)
    todo_1.mark_done
    expect(todolist.incomplete).to eq [todo_2.task]
  end

  it 'returns a list of completed tasks if there are several that have been completed' do
    todolist = TodoList.new
    todo_1 = Todo.new('Walk the dog.')
    todo_2 = Todo.new('Mow the lawn.')
    todolist.add(todo_1)
    todolist.add(todo_2)
    todo_1.mark_done
    todo_2.mark_done
    expect(todolist.complete).to eq [todo_1.task, todo_2.task]
  end

  it 'will mark all tasks on the list as complete if told to mark_all_done' do
    todolist = TodoList.new
    todo_1 = Todo.new('Walk the dog.')
    todo_2 = Todo.new('Mow the lawn.')
    todolist.add(todo_1)
    todolist.add(todo_2)
    todolist.mark_all_done
    expect(todolist.complete).to eq [todo_1.task, todo_2.task]
  end

  it 'will raise an error if trying to mark_all_done when all tasks are complete' do
    todolist = TodoList.new
    todo_1 = Todo.new('Walk the dog.')
    todo_2 = Todo.new('Mow the lawn.')
    todolist.add(todo_1)
    todolist.add(todo_2)
    todolist.mark_all_done
    expect { todolist.mark_all_done }.to raise_error 'There are no pending tasks!'
  end

  it 'will scan a diary entriy for phone numbers and store them in an array' do
    diary = Diary.new
    diary_entry = DiaryEntry.new('Title', '11111111111, 22222222222, 33333333333')
    diary.add(diary_entry)
    contactbook = ContactBook.new
    expect(contactbook.extract_numbers(diary)).to eq %w[11111111111 22222222222 33333333333]
  end

  it 'will scan all diary entries for phone numbers and store them in an array' do
    diary2 = Diary.new
    diary_entry = DiaryEntry.new('Title', '44444444444, 55555555555, 66666666666')
    diary2.add(diary_entry)
    diary_entry2 = DiaryEntry.new('Title', '77777777777')
    diary2.add(diary_entry2)
    contactbook = ContactBook.new
    expect(contactbook.extract_numbers(diary2)).to eq %w[44444444444 55555555555 66666666666 77777777777]
  end

  it 'will return the list of numbers when requested' do
    diary2 = Diary.new
    diary_entry = DiaryEntry.new('Title', '44444444444, 55555555555, 66666666666')
    diary2.add(diary_entry)
    diary_entry2 = DiaryEntry.new('Title', '77777777777')
    diary2.add(diary_entry2)
    contactbook = ContactBook.new
    contactbook.extract_numbers(diary2)
    expect(contactbook.numbers).to eq %w[44444444444 55555555555 66666666666 77777777777]
  end
end
