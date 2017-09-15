class Stay < ApplicationRecord
  belongs_to :sitter, class_name: "User"
  belongs_to :pet_owner, class_name: "User"
  has_and_belongs_to_many :pets
end
