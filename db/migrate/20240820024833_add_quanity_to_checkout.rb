class AddQuanityToCheckout < ActiveRecord::Migration[7.2]
  def change
    add_column :checkouts, :quantity, :string
    add_column :checkouts, :integer, :string
  end
end
