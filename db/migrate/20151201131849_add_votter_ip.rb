class AddVotterIp < ActiveRecord::Migration
  def change
  	add_column :votes, :ip, :integer
  end
end
