class FixCheckoutsTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :checkouts, :integer, :string
    change_column :checkouts, :quantity, :integer, using: 'quantity::integer'
  end
end
