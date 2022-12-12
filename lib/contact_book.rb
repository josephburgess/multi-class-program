class ContactBook
  def initialize
    @contacts = []
  end

  def extract_numbers(diary)
    diary.instance_variable_get(:@entries).each { |entry| @contacts << entry.contents.scan(/\d{11}/) }
    @contacts.flatten!
  end

  def numbers
    @contacts
  end
end
