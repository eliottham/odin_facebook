class PostsController < ApplicationController
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to request.referrer || root_url, notice: "Post created."
		else
			redirect_to request.referrer, flash: { :error => @post.errors.full_messages.join(', ') }
		end
	end

	def show
	end

	def destroy
		Post.find(params[:id]).destroy
		redirect_to request.referrer || root_url, notice: "Post deleted."
	end


	private

		def post_params
			params.require(:post).permit(:content)
		end

end
