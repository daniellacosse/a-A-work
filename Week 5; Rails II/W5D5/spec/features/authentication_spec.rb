require 'spec_helper'


feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end


  feature "signing up a user" do
    before(:each) { sign_up_example_user }

    it "shows username on the homepage after signup" do
      expect(page).to have_content "example_username"
    end
  end

end

feature "logging in" do
  before(:each) { sign_in_example_user }

  it "shows username on the homepage after login" do
    expect(page).to have_content 'example_username'
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content "Sign In"
  end

  it "doesn't show username on the homepage after logout" do
    sign_in_example_user
    click_on "Sign Out"
    expect(page).not_to have_content 'example_username'
  end

end
