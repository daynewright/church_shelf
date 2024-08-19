class AddIndexToCheckout < ActiveRecord::Migration[7.2]
  def change
    add_index :checkouts, [ :user_id, :resource_id ], unique: true
  end
end
