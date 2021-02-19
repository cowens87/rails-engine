class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if !params[:quantity].nil?
      merchants = Merchant.top_by_revenue(params[:quantity]) if !params[:quantity].nil?
      render json: MerchantNameRevenueSerializer.new(merchants)
    else
      render json: {"error" => {}}, status:400
    end
  end
  
  def show
    revenue = Merchant.total_revenue.find(params[:id])
    render json: MerchantRevenueSerializer.new(revenue)
  end
end