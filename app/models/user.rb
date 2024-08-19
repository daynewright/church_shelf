class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :checkouts, dependent: :destroy
  has_many :checkout_resources, through: :checkouts, source: :resource, dependent: :destroy

  has_many :wishlists, dependent: :destroy
  has_many :wishlisted_resources, through: :wishlists, source: :resource, dependent: :destroy
end
