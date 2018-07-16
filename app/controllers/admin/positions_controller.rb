class Admin::PositionsController < Admin::AdminController
  before_action :load_position, only: [:show, :destroy, :update]

  def index
    @positions = Position.all
  end

  def show;end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = t("notifi")
      redirect_to admin_positions_path
    else
      render :new
    end
  end

  def edit;end

  def update
    if @position.update_attributes user_params
      flash[:success] = t("update_user")
      redirect_to @position
    elsif
      render :edit
    end
  end

  def destroy
    if @position.users > 0
      flash[:danger] = t("not_delete")
      redirect_to admin_positions_url
    else
      if @position.destroy
        flash[:success] = t("user_deleted")
        redirect_to admin_positions_url
      else
        render :index
      end
    end
  end

  private

  def position_params
    params.require(:position).permit(:name)
  end

  def load_position
    @position = Position.find_by id: params[:id]
    if @position.nil?
      flash[:danger] = t("no_position")
      redirect_to admin_positions_path
    end
  end
end
