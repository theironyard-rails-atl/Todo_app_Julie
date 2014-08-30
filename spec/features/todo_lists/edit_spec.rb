require 'spec_helper'

describe "Editing Todo Lists" do
  let!(:todo_list) {TodoList.create(title:       "Groceries",
                                    description: "Grocery list")}

  def update_todo_lists(options={})
    options[:title] ||= "New Title"
    options[:description] ||= "New Description"

    todo_list = options[:todo_list]

    visit '/todo_lists'
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates a Todo list successfully with correct information" do

    update_todo_lists todo_list: todo_list

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New Title")
    expect(todo_list.description).to eq("New Description")
  end

  it "displays error when title is empty" do
    update_todo_lists todo_list: todo_list, title: ""
    title = todo_list.title

    todo_list.reload

    expect(page).to have_content("error")
    expect(todo_list.title).to eq(title)
  end

  it "displays error when title is less than 3 characters" do
    update_todo_lists todo_list: todo_list, title: "Hi"
    title = todo_list.title

    todo_list.reload

    expect(page).to have_content("error")
    expect(todo_list.title).to eq(title)
  end

  it "displays error when description is empty" do
    update_todo_lists todo_list: todo_list, description: ""
    description = todo_list.description

    todo_list.reload

    expect(page).to have_content("error")
    expect(todo_list.description).to eq(description)
  end

  it "displays error when description is less than 5 characters" do
    update_todo_lists todo_list: todo_list, description: "word"
    description = todo_list.description

    todo_list.reload

    expect(page).to have_content("error")
    expect(todo_list.description).to eq(description)
  end
end
