class Admin::UsersController < Admin::AdminController
  before_action :load_user, only: [:show, :destroy, :update,:edit]

  def index
    @users = User.load_data.paginate(page: params[:page], per_page: Settings.users.page)
    #@import = User::Import.new

    respond_to do |format|
      format.html
      format.csv {send_data @users.to_csv, filename:"users-#{Date.today}.csv"}
    end
  end

  def import
    @import_error = User.import(params[:file])
    if @import_error.size > 0
      flash[:warning] = t("file_wrong") + " " + "#{@import_error}"
      redirect_to admin_users_path
    else
      redirect_to admin_users_path, notice: t("activity_data_imported")
    end
  end

  def show;end

  def edit;end

  def update
    if @user.update_attributes user_params
      redirect_to admin_users_url,notice: t("user_updated")
    else
      redirect_to admin_users_url,notice: t("unable_to_updated")
    end
  end

  def destroy
    if !current_user.admin?
      if @user.destroy
        flash[:success] = t("user_deleted")
        redirect_to admin_users_url
      else
        render :index
      end
    else
      flash[:danger] = t("user_not_deleted")
    end
  end

  private

  def user_params
    params.require(:user).permit(:role,:division_id)
  end

  def load_user
    @user = User.find_by id: params[:id]
    redirect_to admin_users_url if @user.nil?
  end
end
