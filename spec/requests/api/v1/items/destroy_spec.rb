require 'rails_helper'

describe "Items API CRUD Endpoints" do
  describe 'DELETE /books/:id' do
    it "can destroy an item" do
      item = create(:item).id

      expect(Item.count).to eq(1)

      expect{ delete "/api/v1/items/#{item}" }.to change(Item, :count).by(-1)

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect(response).to have_http_status(:no_content)
      expect{Item.find(item)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end