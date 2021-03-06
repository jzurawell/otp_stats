class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  http_basic_authenticate_with Auth::CREDENTIALS


  def page
    @page = params[:page] || 1
  end

  def per_page
    @per_page = params[:per_page] || 40
  end
end
