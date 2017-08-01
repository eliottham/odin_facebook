class Post < ApplicationRecord
	belongs_to :author, class_name: "User"
	
	has_many :comments
	has_many :commenters, through: :comments, source: :user

	has_many :likes
	has_many :liking_users, through: :likes, source: :user
end
