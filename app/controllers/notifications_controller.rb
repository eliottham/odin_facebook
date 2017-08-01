class NotificationsController < ApplicationController
  def index
  	@requested_friends = current_user.requested_friends
  end
end
