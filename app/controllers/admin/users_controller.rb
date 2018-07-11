class Admin::UsersController < Admin::AdminController
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :get_user, only: [:show, :destroy]

  def index
    @users = User.load_data.paginate(page: params[:page], per_page: Settings.users.page)
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
      redirect_to admin_users_url
    else
      render :index
    end
  end

  private

  def get_user
    @user = User.find_by id: params[:id]
    redirect_to root_url if @user.nil?
  end

end
