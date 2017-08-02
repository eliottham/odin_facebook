class LikesController < ApplicationController
	def index
		@likes = Like.where(post_id: params[:post_id])
	end
	
	def create
		@like = current_user.likes.build(post_id: params[:post_id])
		if @like.save
			flash[:notice] = "Liked #{@like.post.author.first_name}'s post."
			redirect_to request.referrer
		else
			flash[:error] = "Unable to like post."
			redirect_to request.referrer
		end
	end

	def destroy
		Like.find(params[:id]).destroy
		flash[:notice] = "Unliked post."
		redirect_to request.referrer
	end
end
