class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.most_revenue(params[:quantity])
  end

  def show
    render json: Merchant.find(params[:id]).revenue
  end
end
