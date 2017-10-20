class UsersController < ApplicationController

    def new
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id

            return redirect_to user_path(user.id)
        end
        flash[:errors] = user.errors.full_messages
        redirect_to :back
    end

    def show
        # @user = User.find(session[:user_id])
        @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
