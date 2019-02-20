class SessionsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]


  def new
    @user = User.new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      @user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = @user.id

      redirect_to @user
    else
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])

        session[:user_id] = @user.id

        redirect_to @user
      else
        flash[:message] = "Your email or password were incorrect."
        redirect_to signin_path
      end
    end
  end

  def destroy
    session.delete :user_id

    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end


end
