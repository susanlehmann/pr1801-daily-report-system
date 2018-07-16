class Admin::DivisionsController < Admin::AdminController
  before_action :load_division, only: [:show, :destroy, :update,:edit]

  def index
    @divisions = Division.all
  end

  def show;end

  def new
    @division = Division.new
  end

  def create
    @division = Division.new division_params
    if @division.save
      flash[:success] = t("notifi")
      redirect_to admin_divisions_path
    else
      render :new
    end
  end

  def edit;end

  def update
    if @division.update_attributes division_params
      flash[:success] = t("update_user")
      redirect_to admin_divisions_path
    elsif
      render :edit
    end
  end

  def destroy
    if @division.employees.count > 0
      flash[:danger] = t("not_delete")
      redirect_to admin_divisions_url
    else
      if @division.destroy
        flash[:success] = t("user_deleted")
        redirect_to admin_divisions_url
      else
        render :index
      end
    end
  end

  private

  def division_params
    params.require(:division).permit :name, :manager_id
  end

  def load_division
    @division = Division.find_by id: params[:id]
    return if @division
      flash[:danger] = t("no_division")
      redirect_to admin_divisions_path
  end
end
