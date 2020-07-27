class TokensController < ApplicationController
  # GET /tokens
  def index
    render json: Token.mainnet, status: :ok
  end
end
