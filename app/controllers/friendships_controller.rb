class FriendshipsController < ApplicationController
  
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
	  if @friendship.save
	  	flash[:notice] = "Friend request sent."
	    redirect_to :back
	  else
	    flash[:error] = "Unable to send friend request."
	    redirect_to :back
	  end
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.update(status: "accepted")
    if @friendship.save
      redirect_to root_url, notice: "Friend request confirmed."
    else
      redirect_to root_url, notice: "Could not confirm friend request."
    end
  end

  def destroy
	  @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friend."
    redirect_to :back
  end
end
