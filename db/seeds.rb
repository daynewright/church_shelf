# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Category.create!(
    name: "Bible Studies"
)
Category.create!(
    name: "Curriculum"
)
Category.create!(
    name: "Theology"
)
Category.create!(
    name: "Devotionals"
)
Category.create!(
    name: "Prayer Resources"
)

10.times do |i|
    total_copies = rand(1..10)
    available_copies = rand(0..total_copies)

    resource = Resource.create!(
      title: Faker::Book.title,
      author: Faker::Book.author,
      description: Faker::Lorem.sentence,
      category_id: Category.pluck(:id).sample, # Randomly selects an existing category ID
      isbn: Faker::Code.isbn,
      published_date: Faker::Date.between(from: '1900-01-01', to: '2024-12-31'),
      publisher: Faker::Book.publisher,
      language: Faker::Nation.language,
      total_copies: total_copies,
      available_copies: available_copies,
      location: Faker::Address.secondary_address,
    )

    resource.image.attach(io: File.open("db/images/image_#{i + 1}.jpeg"), filename: resource.title)
  end
