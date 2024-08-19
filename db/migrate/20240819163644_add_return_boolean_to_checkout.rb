class AddReturnBooleanToCheckout < ActiveRecord::Migration[7.2]
  def change
    add_column :checkouts, :returned, :boolean, default: false, null: false
  end
end
