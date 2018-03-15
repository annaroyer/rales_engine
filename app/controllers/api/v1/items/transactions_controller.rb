class Api::V1::Items::TransactionsController < SearchController
  def show
    render json: Item.find(params[:id]), serializer: BestDayItemSerializer
  end
end
