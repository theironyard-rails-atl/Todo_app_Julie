require 'spec_helper'

describe "Creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||= "My Todo List"
    options[:description] ||= "List of my Todos"

    visit '/todo_lists'
    expect(page).to have_content("New Todo List")
    click_link "New Todo List"

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My Todo List")
  end

  it "displays error when the title is empty" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: ""

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit '/todo_lists'
    expect(page).not_to have_content("List of my Todos")
  end

  it "displays error when the title is less than 3 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: "Hi"

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit '/todo_lists'
    expect(page).not_to have_content("List of my Todos")
  end

  it "displays error when the description is empty" do
    expect(TodoList.count).to eq(0)
    create_todo_list description: ""

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit '/todo_lists'
    expect(page).not_to have_content("List of my Todos")
  end

  it "displays error when the description is less than 5 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_list description: "Word"

    expect(TodoList.count).to eq(0)
    expect(page).to have_content("error")

    visit '/todo_lists'
    expect(page).not_to have_content("List of my Todos")
  end
end
