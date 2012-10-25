class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :fbid
      t.string :name_first
      t.string :name_last
      t.string :encrypted_email
      t.string :token, :str
      t.timestamps
    end
  end
  def self.down
    drop_table :users
  end  
end
