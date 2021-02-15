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

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    ItemSerializer.new(Item.delete(params[:id]))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end