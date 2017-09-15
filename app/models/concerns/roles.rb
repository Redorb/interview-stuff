module Roles
  extend ActiveSupport::Concern

  ROLES = %w(pet_owner sitter).freeze

  def self.roles_to_mask(roles = [])
    (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles=(roles)
    self.roles_mask = Roles.roles_to_mask(roles)
  end

  def roles
    ROLES.reject { |r| ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero? }
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end
