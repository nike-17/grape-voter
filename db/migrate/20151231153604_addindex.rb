class Addindex < ActiveRecord::Migration
  def change
  	add_index :votes, :subject
  	add_index :votes, :name

  end
end
