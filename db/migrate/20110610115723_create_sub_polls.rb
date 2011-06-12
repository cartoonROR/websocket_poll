class CreateSubPolls < ActiveRecord::Migration
  def self.up
    create_table :sub_polls do |t|
      t.integer :poll_id
      t.string  :name
      t.integer :point
      t.timestamps
    end
  end

  def self.down
    drop_table :sub_polls
  end
end
