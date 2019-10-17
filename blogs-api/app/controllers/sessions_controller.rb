class SessionsController < ApplicationController
    def create
     # user = User.find_by!(email: params[:email],password: params[:password])
     #user = User.find_by!(params[:email])
     user = User.find_by(email: params[:email])
     return head(:forbidden) unless user.authenticate(params[:password])
      # .find_by(email: params[:user][:email])
      # .try(:authenticate, params["user"]["password"])
  
      if user
        session[:user_id] = user.id
        render json: {
          status: :created,
          logged_in: true,
          user: user
        }
      else
        render json: { status: 401 }
      end
     end

    def destroy
      session[:user_id] = nil
      render json: { status: 201, logged_in: false }
    end
   end