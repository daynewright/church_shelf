class Resource < ApplicationRecord
  validates :title, presence: true
  validates :available_copies, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: ->(resource) { resource.total_copies }
  }

  has_many :checkouts, dependent: :destroy
  has_many :users, through: :checkouts

  has_many :reviews, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :wishlisted_by_users, through: :wishlists, source: :user

  has_one_attached :image
  belongs_to :category

  # Checks out a resource, reducing available copies
  def checkout!(quantity)
    if quantity <= available_copies
      self.available_copies -= quantity
      save!
    else
      raise "Not enough copies available"
    end
  end

  # Checks if the resource is not available
  def not_available?
    available_copies < 1
  end

  # Updates the resource's rating based on reviews
  def update_rating!
    self.rating = reviews.average(:rating).to_f.round(1)
    save!
  end

  # Checks if a specific user has checked out this resource
  def checked_out_by_user?(user)
    checkouts.where(user: user).where(returned: false).exists?
  end

  # Returns copies to the resource, increasing available copies
  def return!(quantity)
    self.available_copies += quantity
    save!
  end

  # Finds the wishlist entry for a specific user
  def wishlist_for_user(user)
    wishlists.find_by(user: user)
  end
end
