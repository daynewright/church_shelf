class CreateCheckouts < ActiveRecord::Migration[7.2]
  def change
    create_table :checkouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.datetime :checkout_date
      t.datetime :return_date

      t.timestamps
    end
  end
end
