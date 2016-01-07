require 'json'
class AddCandidates < ActiveRecord::Migration
  def change
	create_table :candidates do |t|
      t.string :name, null: false
	  t.text :description, null: false
	  t.string :image, null: false
    end

    file = File.read(File.dirname(__FILE__) + '/data/candidates.json')
	candidates = JSON.parse(file)
	candidates.each do |item|
		candidate = Models::Candidate.new item
		candidate.save!
	end
  end
end
