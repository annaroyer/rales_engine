class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    value = Merchant.total_revenue(search_params)
    render json: { total_revenue: merchant_revenue(value)}
  end

  def show
    revenue = Merchant.find(params[:id]).revenue_dollars(search_params)
    render json: {"revenue"=>revenue}
  end

  private
    def search_params
      if params[:date]
        date = Date.parse(params[:date])
        {created_at: date.beginning_of_day...date.end_of_day}
      end
    end
end
