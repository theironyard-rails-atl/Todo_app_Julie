require 'spec_helper'

describe "Adding ToDo Items" do
  let!(:todo_list) {TodoList.create(title:       "Groceries",
                                    description: "Grocery List")}

  def visit_todo_list(list)
    visit '/todo_lists'

    within 'todo_list_#{list.id}' do
      click_link "List Items"
    end
  end

  it "is successful when adding valid todo items" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Milk"
    click_button "Save"

    expect(page).to have_content("Added Todo List Item")

    within("ul.todo_items") do
      expect(page).to have_content("Milk")
    end
  end

  it "displays error when content is empty" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: ""
    click_button "Save"

    within("div.flash") do
      expect(page).to have_content("Todo item could not be added.")
    end
    expect(page).to have_content("Content can't be blank")
  end


    it "displays error when content is less than 2 characters" do
      visit_todo_list(todo_list)
      click_link "New Todo Item"
      fill_in "Content", with: "a"
      click_button "Save"

      within("div.flash") do
        expect(page).to have_content("Todo item could not be added.")
      end
      expect(page).to have_content("Content is too short.")
    end
end
