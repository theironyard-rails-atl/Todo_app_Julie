require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit '/todo_lists'
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "My Todo List"
    fill_in "Description", with: "List of my Todos"
    click_button "Create Todo List"
    expect(page).to have_content("My Todo List")
  end

  it "displays error when the title is empty" do
    expect(TodoList.count).to eq(0)


    visit '/todo_lists'
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Description", with: "List of my Todos"
    click_button "Create Todo List"

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit '/todo_lists'
    expect(page).not_to have_content("List of my Todos")
  end

  it "displays error when the title is less than three characters" do
    expect(TodoList.count).to eq(0)


    visit '/todo_lists'
    click_link "New Todo List"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "ab"
    fill_in "Description", with: "List of my Todos"
    click_button "Create Todo List"

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit '/todo_lists'
    expect(page).not_to have_content("List of my Todos")
  end
end
