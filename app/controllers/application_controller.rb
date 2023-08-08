class ApplicationController < ActionController::API

  before_action :current_user, only: :authenticate_devise_api_token!
  
  def current_user
    if current_devise_api_token
      @current_user = current_devise_api_token
    else
      render json: {messages: "Unauthorized"}, status: 401
    end
  end
end
