class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      redirect_to users_path
    else
      current_user.follow(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end

  def destroy
    user_relationship = Relationship.find_by(id: params[:id])
    if user_relationship.nil?
      redirect_to users_path
    else
      @user = user_relationship.followed
      current_user.unfollow(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end
end