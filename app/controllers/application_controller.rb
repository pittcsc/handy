class ApplicationController < ActionController::Base
  include Authentication, Pagination

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
