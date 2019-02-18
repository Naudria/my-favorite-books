class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])

      session[:user_id] = @user.id

      redirect_to @user
    else
      flash[:message] = "Your username or password were incorrect."
      redirect_to signin_path

    end
  end
end

def destroy
  session.delete :user_id

  redirect_to_root_path
end

end
