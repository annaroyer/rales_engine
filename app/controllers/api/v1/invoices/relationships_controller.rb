class Api::V1::Invoices::RelationshipsController < ApplicationController
  def show
    binding.pry
    render json: Invoice.find(params[:id])
  end
end
