# frozen_string_literal: true

# add references of user to some model for policy scopes
class AddUserReferencesToModels < ActiveRecord::Migration[8.0]
  def change
    default_user_id = User.first&.id

    add_column :clients, :user_id, :integer
    execute("UPDATE clients SET user_id = #{default_user_id}") if default_user_id
    change_column_null :clients, :user_id, false
    add_foreign_key :clients, :users

    add_column :contracts, :user_id, :integer
    execute("UPDATE contracts SET user_id = #{default_user_id}") if default_user_id
    change_column_null :contracts, :user_id, false
    add_foreign_key :contracts, :users

    add_column :cost_types, :user_id, :integer
    execute("UPDATE cost_types SET user_id = #{default_user_id}") if default_user_id
    change_column_null :cost_types, :user_id, false
    add_foreign_key :cost_types, :users
  end
end
