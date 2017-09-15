class Pet < ApplicationRecord
  has_and_belongs_to_many :stays
  belongs_to :owner, class_name: "User"

  validates_presence_of :name
end
