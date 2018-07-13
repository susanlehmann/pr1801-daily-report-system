class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
   if user && user.authenticate(params[:session][:password])
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    if !user.admin?
      redirect_back_or user
    else
      redirect_to admin_root_path
    end
  else
    flash[:danger] = t("user_error")
    render :new
  end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def callback
    if user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
      flash[:success] = t("notifi")
      session[:user_id] = user.id
      redirect_back_or user
    else
      flash[:error] = t("error")
      redirect_to new_user_path
    end
  end

  def auth_failure
    redirect_to root_path
  end
end
