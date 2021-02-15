class Api::V1::Items::ItemsController < ApplicationController
  def index
    per_page = (params[:per_page] || 20).to_i 
    page = (params[:page] || 1).to_i 
    items = Item.limit(per_page).offset(((page - 1) * per_page))
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  # def query(params)
  #   if params[:name]
  #     Item.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")
  #   elsif params[:description]
  #     Item.where('LOWER(description) LIKE ?', "%#{params[:description].downcase}%")
  #   elsif params[:unit_price]
  #     Item.where(unit_price: params[:unit_price])
    # elsif params[:created_at]
    #   date = Date.parse(params[:created_at])
    #   Item.where(created_at: date.beginning_of_day..date.end_of_day)
    # elsif params[:updated_at]
    #   date = Date.parse(params[:updated_at])
    #   Item.where(updated_at: date.beginning_of_day..date.end_of_day)
    # end
  # end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end