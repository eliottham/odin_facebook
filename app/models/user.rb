class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true }) }, 
  				 through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true }) },
           through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false }) }, 
           through: :friendships, source: :friend
  has_many :requested_friends, -> { where(friendships: { accepted: false }) }, 
           through: :received_friendships, source: :user

  has_many :posts, foreign_key: "author_id"

  has_many :comments
  has_many :commented_posts, through: :comments, source: :post

  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  # Call all friends
  def friends
  	active_friends | received_friends
  end

  # Call friends of pending requests
  def pending
  	pending_friends | requested_friends
  end

  # Get full name of user
  def full_name
  	"#{first_name} #{last_name}"
  end

  # Get friendship between two users
  def friendship_with(other_user)
    if active_friends.include?(other_user) or pending_friends.include?(other_user)
      friendships.find_by(friend_id: other_user.id)
    elsif received_friends.include?(other_user) or requested_friends.include?(other_user)
      received_friendships.find_by(user_id: other_user.id)
    end
  end

end
