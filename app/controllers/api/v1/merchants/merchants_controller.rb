class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    # limits is how we choose how many items are on a page
    # offsets are how we page through them 
    per_page = (params[:per_page] || 20).to_i 
    page = (params[:page] || 1).to_i 
    merchants = Merchant.limit(per_page).offset(((page - 1) * per_page))
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end
