class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:user][:email])

    if user
      if user.try(:authenticate, params[:user][:password])
        session[:user_id] = user.id

        return redirect_to user_path user.id
      end

      flash[:errors] = ['Password is not correct.']
    else
      flash[:errors] = ['Acccount not found, please register first.']
    end
    return redirect_to :back
  end

  def destroy
    session.delete(:user_id) if session[:user_id]
    return redirect_to new_login_path
  end

end
