class Suite < ApplicationRecord
  has_many :runs, dependent: :destroy
end
