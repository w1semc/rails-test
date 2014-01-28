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

class Micropost < ActiveRecord::Base
  attr_accessible :content, :zagolovok, :tag_list
  acts_as_taggable

  belongs_to :user

  validates :user_id,   presence: true
  validates :content,   presence: true
  validates :zagolovok, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'
end
