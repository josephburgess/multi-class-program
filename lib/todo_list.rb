class TodoList
  def initialize
    @list = []
  end

  def add(todo)
    @list << todo
  end

  def all
    raise 'There are no tasks on the list currently.' if @list.empty?
    @list
  end
  
  def complete
    complete_array = []
    @list.each {|todo| complete_array << todo.task if todo.done? == true}
    return "You've not done any tasks yet!" if complete_array.empty?
    complete_array
  end

  def incomplete
    incomplete_array = []
    @list.each {|todo| incomplete_array << todo.task if todo.done? == false}
    return 'There are no pending tasks!' if incomplete_array.empty?
    incomplete_array
  end
  
  def mark_all_done
    raise 'There are no pending tasks!' if @list.empty? || @list.all? {|todo| todo.done? }
    @list.each { |todo| todo.mark_done }
  end
end

