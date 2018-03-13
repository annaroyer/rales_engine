class Api::V1::Merchants::RandomController < ApplicationController
  def index
    random = rand(Merchant.count)
    render json: Merchant.offset(random).first
  end
end
