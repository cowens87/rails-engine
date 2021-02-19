require 'rails_helper'

describe "Items API CRUD Endpoints" do
  describe 'PATCH /items/:id' do
    it "can update a item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: 'Teddy Ruxpin' }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
      
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq(item_params[:name])
    end
  end
end