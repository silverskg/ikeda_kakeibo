class ApplicationController < ActionController::Base
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの編集・削除できません。'
    end
  end

end
