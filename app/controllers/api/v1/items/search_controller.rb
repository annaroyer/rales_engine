class Api::V1::Items::SearchController < SearchController

  def show
    render json: Item.find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private
    def search_params
      super.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
    end
end
