class User < ApplicationRecord
    has_many :preferences , dependent: :destroy
    validates :email, presence: true, uniqueness: true
end
