class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.integer :user_id
      t.string  :name
      t.text    :detail
      t.string :key
      t.timestamps
    end
  end

  def self.down
    drop_table :polls
  end
end
