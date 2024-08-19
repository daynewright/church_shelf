# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

pictures = []
10.times do
  # Generate the URL
  url = Faker::Avatar.image(size: "300x300", format: "png")
  
  # Open the URL and create an io object
  pictures << URI.open(url)
end

10.times do |i|
  # Create a user
  random_user = User.create!(
    email: "test#{i + 1}@gmail.com",
    password: '123456'
  )

  # Update the profile of the user
  random_user.profile.update!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: "US"
  )

  # Attach the picture to the profile
  random_user.profile.picture.attach(io: pictures[i], filename: "#{random_user.profile.first_name}.png")
end

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
      description: Faker::Lorem.paragraph(sentence_count: (5..10).to_a.sample),
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

    (1..5).to_a.sample.times do
        Review.create!({
            comment: "#{Faker::Marketing.buzzwords} and #{Faker::Marketing.buzzwords}. #{Faker::Lorem.paragraph}. #{Faker::Quote.jack_handey}",
            rating: (1..5).to_a.sample,
            user: User.first,
            resource: resource
        })
    end
end
