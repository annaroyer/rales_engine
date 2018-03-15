class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def index
    render json: Customer.favorite_for_merchant(params[:id])
  end
end
