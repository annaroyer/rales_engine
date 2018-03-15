class Api::V1::Merchants::RevenueController < SearchController
  def show
    render json: Merchant.find(params[:id]), serializer: RevenueMerchantSerializer
  end

  private
    def search_params
      super.permit(:created_at)
    end
end
