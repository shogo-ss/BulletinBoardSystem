class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, presence: true, length: { maximum: 50 }
  
  has_many :comments, dependent: :destroy
  #accepts_nested_attributes_for :category_topics, allow_destroy: true
end
