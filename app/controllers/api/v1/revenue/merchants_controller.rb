class Api::V1::Revenue::MerchantsController < ApplicationController
  # def index
  #   revenue = Merchant.total_revenue_between_dates(params[:start], params[:end])
  #   render json: RevenueSerializer.new(revenue)
  # end
  
  def show
    revenue = Merchant.total_revenue.find(params[:id])
    render json: MerchantRevenueSerializer.new(revenue)
  end
end