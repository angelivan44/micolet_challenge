class User < ApplicationRecord
    has_many :preferences , dependent: :destroy
end
