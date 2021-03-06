class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :comment, presence: true
  
  def self.comment_search(search)
      Comment.where(['comment LIKE ?', "%#{search}%"])
  end
end
