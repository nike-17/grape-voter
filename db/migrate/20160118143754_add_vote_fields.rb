class AddVoteFields < ActiveRecord::Migration
  def change
  	add_column :votes, :city_name, :string
	add_column :votes, :real_region_name, :string
	add_column :votes, :country_name, :string
	add_column :votes, :latitude, :string
	add_column :votes, :longitude, :string

  end
end
