class AddRatingToResources < ActiveRecord::Migration[7.2]
  def change
    add_column :resources, :rating, :float, default: 0.0
  end
end
