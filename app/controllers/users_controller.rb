class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user.name
    @user.prototypes
  end
end