class Api::V1::Items::SalesController < SearchController
  def show
    render json: Item.find(params[:id]), serializer: BestDayItemSerializer
  end

  def index
    render json: Item.most_items(params[:quantity])
  end
end
