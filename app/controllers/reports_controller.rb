class ReportsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
  end

  def create
    @report = current_user.reports.build report_params
    if @report.save
      flash[:success] = t("create")
      redirect_to @reports
    else
      render "static_pages/home"
    end
  end

  def destroy
  end

  private
  def report_params
    params.require(:report).permit(:content)
  end
end
