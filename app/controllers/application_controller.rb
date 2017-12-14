class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def isEmail(str)
    return str.include? '@'
  end
end
