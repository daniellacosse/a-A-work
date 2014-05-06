require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.build(:user) }

  describe "::generate_token" do
    it "creates random session token" do
      expect(User.generate_token).to match(/\w|\=/)
    end

    it "creates a token of length 16" do
      expect(User.generate_token.length).to eq(22)
      #because SecureRandom's string is 4/3 times longer than what is passed
    end
  end

  describe "#ensure_session_token" do
    it "sets initial session token" do
      expect(user.instance_eval{ ensure_session_token }).to_not be_nil
    end

    it "doesn't overwrite existing token" do
      current_token = user.instance_eval{ ensure_session_token }
      expect(user.instance_eval{ ensure_session_token }).to eq(current_token)
    end
  end

  describe "#reset_token!" do
    it "resets user's session token" do
      user.instance_eval{ ensure_session_token }
      current_token = user.session_token
      user.password = "password"
      expect(user.reset_token!).to_not eq(current_token)
    end
  end

  describe "#password=" do
    it "sets users encrypted password" do
      user.password = "password"
      expect(user.password_digest).to_not be_nil
    end
  end

  describe "#is_password?" do
    it "checks plain text pw against encrypted pw" do
      user.password = "password"
      expect(user.is_password?("password")).to be_true
    end

    it "rejects an invalid password" do
      user.password = "password"
      expect(user.is_password?("wrong_password")).to_not be_true
    end
  end

  describe "::find_by_credentials" do
    #create some user in some database in space
    it "finds a user by credentials" do
      user.password = "password"
      user.instance_eval{ ensure_session_token }
      user.save!

      expect(

        User.find_by_credentials(
              user.username,
              "password"
        )

      ).to_not be_nil
    end
  end

  describe "Associations" do
    it { should have_many(:subs) }
    it { should have_many(:posts) }
  end
end
