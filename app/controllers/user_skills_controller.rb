class UserSkillsController < ApplicationController
  before_action :logged_in_user,only: [:index, :show]

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
    render 'new'
  end

  def show
    @user_skill = UserSkill.find_by id: params[:id]
  end

  private

  def user_skill_params
    params.require(:user_skill).permit skill_id: []
  end

end
