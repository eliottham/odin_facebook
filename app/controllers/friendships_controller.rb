class FriendshipsController < ApplicationController
  
  def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])
	  if @friendship.save
	    redirect_to :back || root_url, notice: "Friend request sent."
	  else
	    redirect_to :back || root_url, notice: "Unable to send friend request."
	  end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.accepted = true
    if @friendship.save
      redirect_to :back || root_url, notice: "Friend request confirmed."
    else
      redirect_to root_url, notice: "Could not confirm friend request."
    end
  end

  def destroy
	  @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to :back || root_url, notice: "Removed friend."
  end
end
