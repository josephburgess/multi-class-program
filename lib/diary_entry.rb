class DiaryEntry
  def initialize(title, contents)
    @title = title
    @contents = contents
  end

  attr_reader :title, :contents

  def count_words
    @contents.split.count
  end
end
