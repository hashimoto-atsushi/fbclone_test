module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #ユーザーがログインして入れば、true, LOGOUTであればfalse
  def logged_in?
    current_user.present?
  end
end
