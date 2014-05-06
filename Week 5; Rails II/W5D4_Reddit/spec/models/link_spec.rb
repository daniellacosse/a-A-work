require 'spec_helper'

describe Link do

  context "without title, url, poster, sub" do
    let(:incomplete_link) {link = Link.new}

    it "validates presence of title" do
      expect(incomplete_link).to have(1).error_on(:title)
    end

    it "validates presence of poster" do
      expect(incomplete_link).to have(1).error_on(:poster_id)
    end

    it "validates presence of url" do
      expect(incomplete_link).to have(1).error_on(:url)
    end

    it "validates presence of sub" do
      expect(incomplete_link).to have(1).error_on(:sub_id)
    end
  end

  describe "Associations" do
    it { should belong_to(:poster) }
    it { should have_many(:subs) }
  end

end
