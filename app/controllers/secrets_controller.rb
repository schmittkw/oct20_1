class SecretsController < ApplicationController

  def create
    user = User.find(session[:user_id])
    secret = Secret.create(content: secret_params[:content], user: user)
    puts secret
    if secret.valid?
      return redirect_to secrets_path
    end
    flash[:errors] = secret.errors.full_messages
    redirect_to :back
  end

  def show
    @secrets = Secret.all.order! 'created_at DESC'
    # @secrets = Secret.joins(:likes).where("secret.id = likes.secret_id").order! 'created_at DESC'
    return render 'secrets/show'
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.delete
    return redirect_to :back
  end

  def like
    secret = Secret.find(params[:id])
    Like.create(user: current_user, secret: secret)
    return redirect_to :back
  end

  def unlike
    like = Like.find_by_user_id_and_secret_id(current_user.id, params[:id])
    like.delete
    return redirect_to :back
  end

  def show_all
    @secrets = Secret.all
    render 'secrets/all'
  end

  private
  def secret_params
      params.require(:secret).permit(:content)
  end
end