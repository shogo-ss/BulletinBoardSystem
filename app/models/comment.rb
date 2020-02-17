class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :comment, presence: true
end
