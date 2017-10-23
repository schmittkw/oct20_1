class UsersController < ApplicationController
    
        def new
            if current_user
                return redirect_to user_path current_user.id
            end
            return render 'users/new'
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
             @user = User.find(session[:user_id])
             # @user = User.find(params[:id])
            # @user.secrets_liked.any? secret
            # @secrets_liked = User.secrets_liked.all
            @secrets_made = Secret.where(user_id: session[:user_id])
            render 'users/show'
         end
     
         def edit
            @user = User.find(session[:user_id])
            render 'users/edit'
        end
    
        def update
            user = User.find(session[:user_id])
            user.update(user_params) 
            return redirect_to "/users/#{user.id}"        
        end
    
        private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
    end