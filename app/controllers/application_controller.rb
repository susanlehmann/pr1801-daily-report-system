class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options options = {}
    {locale: I18n.locale}
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t("log_in")
      redirect_to login_path
    end
  end

  def set_current_user
    User.current = current_user
  end
end
