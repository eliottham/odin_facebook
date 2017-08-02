class PostsController < ApplicationController
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:notice] = "Post created."
			redirect_to request.referrer || root_url
		else
			redirect_to request.referrer, flash: { :error => @post.errors.full_messages.join(', ') }
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:notice] = "Post deleted."
		redirect_to request.referrer || root_url
	end


	private

		def post_params
			params.require(:post).permit(:content)
		end

end
