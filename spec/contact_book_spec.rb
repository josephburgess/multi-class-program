require 'contact_book'

RSpec.describe ContactBook do
  it 'initializes with an empty array to store phone numbers' do
    contactbook = ContactBook.new
    expect(contactbook.instance_variable_get(:@contacts)).to eq []
  end
end
