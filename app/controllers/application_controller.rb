class ApplicationController < ActionController::API

  def live
    render json: Time.now.utc
  end
  
end
