class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :checkouts, dependent: :destroy
  has_many :checkout_resources, through: :checkouts, source: :resource

  has_many :wishlists, dependent: :destroy
  has_many :wishlisted_resources, through: :wishlists, source: :resource

  has_one :profile, dependent: :destroy

  after_create :create_profile_if_needed

  private

  def create_profile_if_needed
    create_profile if profile.nil?
  end
end
