class CommentsController < ApplicationController
	after_filter "save_previous_url", only: :index

	def index
		@comments = Comment.where(post_id: params[:post_id])
	end

	def create
		post = Post.find(params[:post_id])
		comment = post.comments.build(comments_params)
		if comment.save
			flash[:notice] = "Comment posted."
			redirect_to request.referrer or root_url
		else
			redirect_to request.referrer, flash: { :error => comment.errors.full_messages.join(', ') }
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:notice] = "Comment deleted."
		redirect_to request.referrer or root_url
	end


	private

		def comments_params
			params.require(:comment).permit(:user_id, :content)
		end

end
