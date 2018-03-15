class SearchController < ApplicationController
    def unformat_price(price)
      (price.to_f * 100).to_i
    end

    def search_params
      if params[:date]
        date = Time.parse(params[:date])
        params[:created_at] = date.beginning_of_day...date.end_of_day
      end
      params[:unit_price] = unformat_price(params[:unit_price]) if params[:unit_price]
      params
    end
end
