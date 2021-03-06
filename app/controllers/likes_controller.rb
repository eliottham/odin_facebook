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
			redirect_to :back || root_url, notice: "Liked #{like.post.author.first_name}'s post."
		else
			redirect_to :back, alert: "Unable to like post."
		end
	end

	def destroy
		Like.find(params[:id]).destroy
		redirect_to :back, notice: "Unliked post."
	end

	private

	  # Redirect to the page where the post was seen (either user's show page or home)
    def save_previous_url
			unless request.referer.include?('likes')
				session[:previous_url] = URI(request.referrer).path
			end
		end
end
