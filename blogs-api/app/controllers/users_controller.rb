class UsersController < ApplicationController
    # POST /signup
      def create
        @user = User.create!(user_params)
        session[:user_id] = @user.id
        json_response(@user, :created)
      end
    
      private
    
      def user_params
        params.permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
      
    