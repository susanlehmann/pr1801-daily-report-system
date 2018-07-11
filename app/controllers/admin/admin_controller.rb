class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :authorized?


  def index
  end

  private
  def authorized?
    unless current_user.admin?
      flash[:error] = "You are not authorized to view that page"
      redirect_to current_user
    end
  end
end
