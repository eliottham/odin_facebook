class StaticPagesController < ApplicationController

	def home
		if user_signed_in?
			@post = current_user.posts.build
			ids = current_user.friends.pluck(:id) << current_user.id
			@feed = Post.where(author_id: ids)
			if current_user.requested_friends.count != 0
				flash.now[:notice] = "(#{current_user.requested_friends.count}) 
									            #{'Friend Request'.pluralize(current_user.requested_friends.count)}"
			end
		end
	end

	def notifications
		@friend_requests = current_user.requested_friends
	end
	
end
