# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  micropost_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Comment do
  let(:micropost) { FactoryGirl.create(:micropost) }
  before { @comment = micropost.comments.build(content: "Lorem ipsum") }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:micropost_id) }
  it { should respond_to(:micropost) }
  its(:micropost) { should == micropost }

  it { should be_valid }

  describe "with blank content" do
    before { @comment.content = " " }
    it { should_not be_valid }
  end
end
