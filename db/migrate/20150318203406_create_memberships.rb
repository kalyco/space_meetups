class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :meetup_id, null: false
      t.integer :user_id, null: false
      t.index [:user_id, :meetup_id], unique: true
    end
  end
end
