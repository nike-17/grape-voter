class RemoveName < ActiveRecord::Migration
  def change
  	remove_column :votes, :name
  end
end
