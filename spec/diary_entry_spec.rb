require 'diary_entry'

RSpec.describe DiaryEntry do
  contents1 = 'bananas ' * 100
  it 'will initialize with title' do
    diary_entry = DiaryEntry.new('my_title', 'my_contents')
    expect(diary_entry.title).to eq 'my_title'
  end

  it 'will initialize with contents' do
    diary_entry = DiaryEntry.new('my_title', 'my_contents')
    expect(diary_entry.contents).to eq 'my_contents'
  end

  it 'will return a word count of a given entry' do
    diary_entry = DiaryEntry.new('Title', contents1)
    expect(diary_entry.count_words).to eq 100
  end
end
