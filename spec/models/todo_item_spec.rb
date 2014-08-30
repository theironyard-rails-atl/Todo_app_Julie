require 'rails_helper'

RSpec.describe TodoItem, :type => :model do
  it {should have_many(:todo_items) }
end
