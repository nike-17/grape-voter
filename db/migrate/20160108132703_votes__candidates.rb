class VotesCandidates < ActiveRecord::Migration
  def change
	change_table :votes do |t|
  		t.belongs_to :candidate, index: true
  	end
  end
end
