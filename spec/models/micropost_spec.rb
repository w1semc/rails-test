# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  zagolovok  :string(255)
#

require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(zagolovok: "Lorem ipsum", 
                                              content:   "Lorem ipsum") }

  subject { @micropost }
  it { should respond_to(:zagolovok) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  it { should respond_to(:comments) }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " && @micropost.zagolovok = " "}
    it { should_not be_valid }
  end
  describe "when title is too long" do
    before { @micropost.zagolovok = "a" * 141 }
    it { should_not be_valid }
  end

  describe "comment associations" do
    before { @micropost.save }
    let!(:older_comment) do
      FactoryGirl.create(:comment, micropost: @micropost, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, micropost: @micropost, created_at: 1.hour.ago)
    end

    it "should have the right comments in the right order" do
      @micropost.comments.should == [newer_comment, older_comment]
    end
  end
end
