class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :authorized?

  def index;end

  private
  def authorized?
    unless current_user.admin?
      flash[:error] = t("no_privilege")
      redirect_to current_user
    end
  end
end
