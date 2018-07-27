class UsersController < ApplicationController
  layout "application"
  add_breadcrumb "Dashboard", :current_user
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show,:following,:followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: [:destroy]
  before_action :find_user, only: [:edit, :update, :show,:followers,:following]

  def index
    if current_user.manager?
      @users = User.same_division.load_user.load_data.paginate(page: params[:page], per_page: Settings.users.page)
      if params[:q]
        @users = User.same_division.where("name LIKE ? OR email LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").paginate(page: params[:page], per_page: Settings.users.page)
      else
        @users
      end
    else
      @users = User.load_user.paginate(page: params[:page], per_page: Settings.users.page)
      if params[:q]
        @users = User.where("name LIKE ? OR email LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").paginate(page: params[:page], per_page: Settings.users.page)
      else
        @users
      end
    end
  end

  def show
    @reports = @user.reports.load_data
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("notifi")
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    add_breadcrumb "My Profile", :user_path
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t("update_user")
      redirect_to @user
    elsif
      render :edit
    end
  end

  def following
    @title = t"following"
    @users = @user.following.paginate(page: params[:page], per_page: Settings.users.page)
    render 'show_follow'
  end

  def followers
    @title = t"followers"
    @users = @user.followers.paginate(page: params[:page], per_page: Settings.users.page)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation,:position_id, :avatars)
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless  @user == current_user
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t("no_user")
      redirect_to current_user
    end
  end

  def verify_admin
    redirect_to current_user unless !current_user.admin?
  end

  def manager_user
    redirect_to current_user unless current_user.manager?
  end
end
