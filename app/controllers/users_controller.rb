class UsersController < ApplicationController
  add_breadcrumb "Dashboard", :current_user
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: [:edit, :update, :show]
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = t(:notifi)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    add_breadcrumb "My Profile", :user_path
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    elsif
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation, :avatars)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "please log in."
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless  @user == current_user
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = "No User"
      redirect_to current_user
    end
  end
end
