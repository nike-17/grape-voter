class UpdateVotes < ActiveRecord::Migration
  def change
  	rename_column :votes, :type, :subject
  end
end
