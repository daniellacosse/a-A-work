require 'spec_helper'

describe Sub do
  context "without name or mod" do
    let(:incomplete_sub) {sub = Sub.new}

    it "validates presence of name" do
      expect(incomplete_sub).to have(1).error_on(:name)
    end

    it "validates presence of mod" do
      expect(incomplete_sub).to have(1).error_on(:mod_id)
    end
  end

  it "validates uniqueness of sub" do
    sub1 = Sub.create!({name: "lolhaxwtf", mod_id: 1})
    sub2 = Sub.new({name: "lolhaxwtf", mod_id: 2})

    expect(sub2).not_to be_valid
  end

  describe "Associations" do
    it { should belong_to(:moderator) }
  end

end


