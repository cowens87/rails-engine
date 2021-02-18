class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = Merchant.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%").first
    if merchant.nil?
      render json: {"data" => {}}, status:200
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
