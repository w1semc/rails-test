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

class Comment < ActiveRecord::Base
  attr_accessible :content, :micropost_id, :user_id
  belongs_to :micropost

  validates :content, presence:true

  default_scope order: 'comments.created_at DESC'
end
