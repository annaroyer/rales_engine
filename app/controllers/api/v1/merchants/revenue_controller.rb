class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    value = Merchant.total_revenue(params[:date])
    require "pry"; binding.pry
    render json: {total_revenue => value}
  end
end
