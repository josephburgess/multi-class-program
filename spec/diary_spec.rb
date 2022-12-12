require 'diary.rb'

RSpec.describe Diary do

  it 'will initialize with an empty list of entries' do
    diary = Diary.new
    expect(diary.list).to eq []
  end

end