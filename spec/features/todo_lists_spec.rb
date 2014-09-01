require 'spec_helper'

describe "TodoLists" do
  it {should have_many (:todo_items)}

#TODO: need test for complete items
end
