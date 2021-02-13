class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :credit_card_expiration_date
      t.string :result, default: 'success'
      t.string :credit_card_number
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
