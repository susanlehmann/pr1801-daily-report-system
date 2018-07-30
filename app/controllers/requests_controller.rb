class RequestsController < ApplicationController
  before_action :logged_in_user,only: [:index,:new, :show]
  before_action :find_request,only: [:show,:verify,:reject,:edit,:update]

  def index
    @requests = if current_user.manager?
      Request.all
      if params[:d].present?
        @reports = @reports.search(params[:d])
      else
        @reports
      end
    else
      current_user.requests
      if params[:d].present?
        @reports = @reports.search(params[:d])
      else
        @reports
      end
    end
  end

  def new
    @request = Request.new
  end

  def edit;end

  def update
    if @request.update_attributes request_params
      flash[:success] = t("update_request")
      redirect_to requests_path
    else
      render :edit
    end
  end

  def create
    @request = Request.new request_params
    @request.user = current_user
    if @request.save
      flash[:success] = t("notifi")
      redirect_to requests_path
    else
      render :new
    end
  end

  def show
    @request = Request.find_by id: params[:id]
  end

  def verify
    if @request.verify current_user
      redirect_to requests_path, notice: t("Successful_review")
    else
      redirect_to requests_path, alert: t("Audit_failure")
    end
  end

  def reject
    if @request.reject current_user
      redirect_to requests_path, notice: t("Dismissed_successfully")
    else
      redirect_to requests_path, alert: t("Dismissal_failure")
    end
  end
  private

  def request_params
    params.require(:request).permit :check_out, :check_in, :requests_type_id, :reason
  end

  def find_request
    @request = Request.find_by id: params[:id]
    if @request.nil?
      flash[:danger] = t("no_result")
      redirect_to requests_path
    end
  end

end
