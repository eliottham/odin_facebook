class Post < ApplicationRecord
	validates :author_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }
	
	belongs_to :author, class_name: "User"
	
	has_many :comments, dependent: :destroy
	has_many :commenters, through: :comments, source: :user

	has_many :likes, dependent: :destroy
	has_many :liking_users, through: :likes, source: :user
end
