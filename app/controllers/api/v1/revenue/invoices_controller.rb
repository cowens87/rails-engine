class Api::V1::Revenue::InvoicesController < ApplicationController
 def index
    begin
      invoice_revenue = Invoice.potential_revenue(params[:quantity])
      render json: InvoiceRevenueSerializer.new(invoice_revenue)
    rescue
      render json: {"error" => {}}, status: 400
    end
  end
end