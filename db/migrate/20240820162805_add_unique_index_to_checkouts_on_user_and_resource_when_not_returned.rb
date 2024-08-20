class AddUniqueIndexToCheckoutsOnUserAndResourceWhenNotReturned < ActiveRecord::Migration[6.0]
  def change
    # Remove the existing unique index if it exists
    remove_index :checkouts, [ :user_id, :resource_id ] if index_exists?(:checkouts, [ :user_id, :resource_id ])

    # Add the partial unique index
    add_index :checkouts, [ :user_id, :resource_id ], unique: true, where: "returned = false", name: 'index_checkouts_on_user_id_and_resource_id_when_not_returned'
  end
end
