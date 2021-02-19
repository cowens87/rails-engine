class Api::V1::Merchants::SearchController < ApplicationController
  def find
    merchant = Merchant.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%").first
    if merchant.nil?
      render json: {"data" => {}}, status:200
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  def most_items
    merchants = Merchant.most_items_sold(params[:quantity])
     if params[:quantity].class != String
      render json: {"error" => {}}, status:400
     else
      render json: MerchantItemSerializer.new(merchants)
     end
  end
end
