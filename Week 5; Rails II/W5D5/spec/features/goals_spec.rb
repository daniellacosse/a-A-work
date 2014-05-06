require 'spec_helper'

feature "goals#create" do

  before(:each) { sign_in_example_user }

  it "can successfully create a goal" do
    create_example_goal
    expect(Goal.last.name).to eq("my_sample_goal")
  end

end

feature "goals#show" do

  before(:each) { sign_in_example_user }

  it "displays a goal" do
    create_example_goal
    goal = Goal.find_by_name("my_sample_goal")
    visit goal_url(goal)
    expect(page).to have_content("my_sample_goal")
  end

end

feature "goals#update" do

  before(:each) { sign_in_example_user }

  it "can successfully update a goal" do
    create_example_goal
    goal = Goal.find_by_name("my_sample_goal")
    visit edit_goal_url(goal)
    fill_in "Description", with: "new_and_improved_example_description"
    click_button("Update Goal")
    expect(page).to have_content("new_and_improved_example_description")
  end


end

feature "goals#destroy" do

  before(:each) { sign_in_example_user }

  it "can successfully destroy a goal" do
    create_example_goal
    goal = Goal.find_by_name("my_sample_goal")
    visit goal_url(goal)
    click_button("X")
    expect(page).not_to have_content("my_sample_goal")
  end

end