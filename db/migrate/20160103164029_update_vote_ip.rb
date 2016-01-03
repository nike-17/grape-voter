class UpdateVoteIp < ActiveRecord::Migration
  def change
  	change_column :votes, :ip, :integer, :limit => 8
  end
end
