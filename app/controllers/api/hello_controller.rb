class Api::HelloController < ActionController::API
  def create
    render json: { message: "Hello Abhik" }
  end
end
