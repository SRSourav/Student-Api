class Item < ApplicationRecord
  belongs_to :student

    # validation
  validates_presence_of :name
end
