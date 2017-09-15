require 'csv'

namespace :data_migration do
  desc "Imports CSV into rails database in a complete batch, very memory intensive ~9GB"
  task bulk_csv_import: :environment do
    file_name = File.join Rails.root, "reviews.csv"
    CSV.foreach(file_name, headers: true) do |row|
      row_hash = row.to_hash
      sitter = create_sitter_from_csv_row(row_hash)
      pet_owner = create_pet_owner_from_csv_row(row_hash)
      stay = create_stay_from_csv_row(row_hash, sitter.id, pet_owner.id)
      create_pets_from_csv_row(row_hash, pet_owner.id, stay)
    end
    calculate_sitter_ratings
  end

  private
  def calculate_sitter_ratings()
    sitters = User.where(roles_mask: Roles.roles_to_mask(%w[sitter pet_owner]))
    sitters.each do |sitter|
      sitter.update_all_scores
    end
  end

  def create_sitter_from_csv_row(row_hash)
    user = User.find_by(email: row_hash['sitter_email'])
    unless user
      name = row_hash['sitter'].split(' ')
      user = User.new(
        first_name: name[0],
        last_name: name[1][0],
        email: row_hash['sitter_email'],
        phone_number: row_hash['sitter_phone_number'],
        avatar_url: row_hash['sitter_image'],
        password: 'password',
        password_confirmation: 'password',
      )
    end
    user.roles = user.roles.push('sitter')
    user.save!
    user
  end
  def create_pet_owner_from_csv_row(row_hash)
    user = User.find_by(email: row_hash['owner_email'])
    unless user
      name = row_hash['owner'].split(' ')
      user = User.create(
        first_name: name[0],
        last_name: name[1][0],
        email: row_hash['owner_email'],
        phone_number: row_hash['owner_phone_number'],
        avatar_url: row_hash['owner_image'],
        password: 'password',
        password_confirmation: 'password'
      )
    end
    user
  end
  def create_pets_from_csv_row(row_hash, owner_id, stay)
    pet_names = row_hash['dogs'].split('|')
    pet_names.map do |pet|
      pet = Pet.find_or_create_by(
        name: pet,
        owner_id: owner_id
      )
      stay.pets << pet
    end 
    stay.save!
  end
  def create_stay_from_csv_row(row_hash, sitter_id, pet_owner_id)
    Stay.find_or_create_by(
      start_date: row_hash['start_date'],
      end_date: row_hash['end_date'],
      text: row_hash['text'],
      rating: row_hash['rating'],
      sitter_id: sitter_id,
      pet_owner_id: pet_owner_id
    )
  end
end
