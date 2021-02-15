  class Api::V1::Items::SearchController < ApplicationController
    def index
      items = Item.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")

      return nil if items.nil? || items.empty?

      render json: ItemSerializer.new(items)
    end
  end