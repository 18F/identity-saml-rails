# rubocop:disable MethodLength
class ChangeUsersTable < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :social_security_number, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :phone, :string
    add_column :users, :street_address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string

    add_index :users, :social_security_number
  end
end
# rubocop:enable MethodLength
