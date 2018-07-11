class RequestsController < ApplicationController
  before_action :logged_in_user,only: [:index,:new, :show]

  def index
    @requests = if current_user.manager?
                  Request.all
                else
                  current_user.requests
                end
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      flash[:success] = t(:notifi)
      redirect_to requests_path
    else
      render 'new'
    end
  end

  def show
    @request = Request.find_by id: params[:id]
  end

  def verify
    obj = Request.find_by id: params[:id]

    if obj.verify(current_user)
      redirect_to requests_path, notice: "Successful review"
    else
      redirect_to requests_path,alert: "Audit failure"
    end
  end

  def reject
    obj = Request.find_by id: params[:id]
    if obj.reject(current_user)
      redirect_to requests_path, notice: "Dismissed successfully"
    else
      redirect_to requests_path, alert: "Dismissal failure"
    end
  end
  private

  def request_params
    params.require(:request).permit :check_out, :check_in, :requests_type_id, :reason
  end

end
