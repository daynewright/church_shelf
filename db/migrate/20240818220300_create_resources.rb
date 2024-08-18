class CreateResources < ActiveRecord::Migration[7.2]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.string :author
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.string :isbn
      t.date :published_date
      t.string :publisher
      t.string :language
      t.integer :total_copies, default: 1
      t.integer :available_copies, default: 1
      t.string :location

      t.timestamps
    end
  end
end
