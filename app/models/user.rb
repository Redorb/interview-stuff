class User < ApplicationRecord
  include Roles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sittings, 
           class_name: "Stay",
           foreign_key: "sitter_id",
           dependent: :destroy
  has_many :bookings,
           class_name: "Stay",
           foreign_key: "pet_owner_id",
           dependent: :destroy
  has_many :pets,
           class_name: "Pet",
           foreign_key: "owner_id",
           dependent: :destroy

  scope :sitters, -> { where(roles_mask: Roles.roles_to_mask(%w[sitter pet_owner])) }
  scope :pet_owners, -> { where(roles_mask: Roles.roles_to_mask(%w[pet_owner])) }
  scope :with_details, -> { includes(:sittings, :bookings, :pets) }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def weighting
    (self.rating_score - self.sitter_score) / 10
  end

  def calculate_sitter_score
    unique_chars = full_name.downcase.gsub(/\W+/, '').split('').uniq.length.to_f
    5 * (unique_chars / 26)
  end

  def calculate_overall_score
    num_sittings = self.sittings.length
    if (num_sittings == 0)
      self.sitter_score
    elsif (num_sittings < 10)
      weighting * num_sittings + self.sitter_score
    else
      self.rating_score
    end
  end

  def calculate_rating_score
    self.sittings.average(:rating)
  end

  def update_all_scores
    self.sitter_score = calculate_sitter_score
    self.rating_score = calculate_rating_score
    self.overall_score = calculate_overall_score
    self.save!
  end
end
