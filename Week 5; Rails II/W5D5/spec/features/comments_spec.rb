require 'spec_helper'

feature "users and goals are commentable" do

  feature "create" do
    it "can be created on goal" do
      create_example_comment_on_goal

      expect(page).to have_content("my_sample_comment")

    end

    it "can be created on user" do
      create_example_comment_on_user

      expect(page).to have_content("my_sample_comment")
    end
  end

  feature "destroy" do
    it "can be deleted on goal" do
      create_example_comment_on_goal
      click_on "delete comment"
      expect(page).not_to have_content("my_sample_comment")
    end

    it "can be deleted on user" do
      create_example_comment_on_user

      click_on "delete comment"

      expect(page).not_to have_content("my_sample_comment")
    end

  end
end

