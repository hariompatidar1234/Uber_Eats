  class UsersController < ApplicationController
    # before_action :authenticate_request, except: %i[create login forgot_password reset_password]

    def index
      @users =  User.all
    end

    def create
      user = User.new(user_params)
      if user.save
        # UserMailer.with(user: user).welcome_email.deliver_now
        # flash.notice = 'the account  successfully saved'
        render json: user, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      @current_user
    end

    def update
      if @current_user.update(user_params)
        render json: { data: @current_user, message: 'User updated' }
      else
        render json: { error: @current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end


    def destroy
      if @current_user.destroy
        render json: { data: @current_user,message: 'User deleted' }
      else
        render json: { error: 'User deletion failed' }
      end
    end


    private

    def user_params
      params.require(:user).  permit(:name, :email, :contact, :password, :type,:picture)
    end
  end



