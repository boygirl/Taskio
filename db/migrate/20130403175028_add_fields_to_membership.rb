class AddFieldsToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :name, :string
    add_column :memberships, :phone, :string
    rename_column :memberships, :user_email, :email
  end
end
