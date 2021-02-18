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
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(Item.create(item_params)), status: :created
    end
  end

  def update
    begin
      item = Item.find(params[:id])
      item.update!(item_params)
      render json: ItemSerializer.new(item), status:202    
    rescue
      render json: {"error" => {}}, status:404
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    head :no_content
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end