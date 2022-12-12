class Diary
  def initialize
    @entries = [] 
  end

  def add(entry)
    @entries << entry
  end

  def list
    @entries
  end

  def all
    entry_string = ""
    @entries.each do |entry|
      entry_string << "\n **#{entry.title}** \n #{entry.contents} "
    end
    entry_string
  end

  def best_entry_for_reading_time(wpm, minutes)
    raise 'WPM must be more than zero.' if wpm == 0
    number_of_words = wpm * minutes
    sorted_entries = @entries.sort_by {|entry| entry.count_words}
    raise 'There are no entries you can read.' if sorted_entries.select {|entry| entry.count_words <= number_of_words} == []
    sorted_entries.select {|entry| entry.count_words <= number_of_words}[-1].contents
  end

end

