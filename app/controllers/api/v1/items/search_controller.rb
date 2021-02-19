  class Api::V1::Items::SearchController < ApplicationController
    def find_all
      items = Item.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")
      if params[:name].empty?
        render json: {"data" => []}, status:200
      else
        render json: ItemSerializer.new(items)
      end
    end
  end