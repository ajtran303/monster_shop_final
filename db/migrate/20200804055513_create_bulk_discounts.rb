class CreateBulkDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bulk_discounts do |t|
      t.integer :bulk_quantity
      t.integer :percentage_discount
      t.references :merchant, foreign_key: true
    end
  end
end
