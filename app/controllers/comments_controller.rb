class CommentsController < ApplicationController
	after_action :save_previous_url, only: :index

	def index
		@comments = Comment.where(post_id: params[:post_id])
	end

	def create
		post = Post.find(params[:post_id])
		comment = post.comments.build(comments_params)
		if comment.save
			flash[:notice] = "Comment posted."
			redirect_to :back || root_url
		else
			redirect_to :back, flash: { alert: comment.errors.full_messages.join(', ') }
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:notice] = "Comment deleted."
		redirect_to :back || root_url
	end


	private

		def comments_params
			params.require(:comment).permit(:user_id, :content)
		end

		# Redirect to the page where the post was seen (either user's show page or home)
	  def save_previous_url
	    unless request.referer.include?('comments')
	      session[:previous_url] = URI(request.referer).path
	    end
	  end

end
