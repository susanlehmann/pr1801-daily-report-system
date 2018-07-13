class UserSkillsController < ApplicationController
  before_action :logged_in_user,only: [:index, :show]
  before_action :find_user_skill,only: [:show]

  def index
    @user_skills = UserSkill.all
  end

  def new
    @user_skill = UserSkill.new
  end

  def create
    ActiveRecord::Base.transaction do
      current_user.skill_ids = user_skill_params[:skill_id]
      flash[:success] = t(:notifi)
      redirect_to user_skills_path
    end
  rescue ActiveRecord::RecordNotFound
    render :new
  end

  def show
  end

  private

  def user_skill_params
    params.require(:user_skill).permit skill_id: []
  end

  def find_user_skill
    @user_skill = UserSkill.find_by id: params[:id]
    if @request.nil?
      flash[:danger] = t("No_Result")
      redirect_to requests_path
    end
  end

end
