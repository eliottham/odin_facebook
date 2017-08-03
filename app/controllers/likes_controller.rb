class LikesController < ApplicationController
	after_filter "save_previous_url", only: :index

	def index
		@likes = Like.where(post_id: params[:post_id])
	end
	
	def create
		post = Post.find(params[:post_id])
		like = post.likes.build(user_id: current_user)
		like = current_user.likes.build(post_id: params[:post_id])
		if like.save
			flash[:notice] = "Liked #{like.post.author.first_name}'s post."
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
