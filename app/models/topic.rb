class Topic < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, presence: true, length: { maximum: 100 }
  
  has_many :comments, dependent: :destroy
  #accepts_nested_attributes_for :category_topics, allow_destroy: true
  
  def self.topic_search(search)
      return Topic.all unless search
      Topic.where(['name LIKE ?', "%#{search}%"])
  end
end
