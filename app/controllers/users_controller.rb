class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render json: @user
    else
      render json: {error: "User not found"}, status: 404
    end
  end

  def create
    @user = User.new(email: params[:username], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])

    if @user.save
      render json: @user
    else
      render json: {error: "Unable to create user"}, status: 400
    end
  end


  def signin
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: @user
    else
      render json: {error: "Username/password combination invalid."}, status: 400
    end
end

end
