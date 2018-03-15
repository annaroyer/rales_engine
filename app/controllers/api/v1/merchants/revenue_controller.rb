class Api::V1::Merchants::RevenueController < SearchController
  def show
    render json: Merchant.find(params[:id]).revenue(search_params)
  end

  private
    def search_params
      super.permit(:created_at)
    end
end
