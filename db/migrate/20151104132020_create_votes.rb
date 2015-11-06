class CreateVotes < ActiveRecord::Migration
  def change
  	create_table :votes do |t|
      t.string :name, null: false
	  t.string :type, null: false
	  t.integer :ammount, null: false
      t.timestamps null: false
    end
  end
end
