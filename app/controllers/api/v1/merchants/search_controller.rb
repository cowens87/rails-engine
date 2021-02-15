class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = Merchant.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%").first

    return nil if merchant.nil? 

    render json: MerchantSerializer.new(merchant)
  end
end
