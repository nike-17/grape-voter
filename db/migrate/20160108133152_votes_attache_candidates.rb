class VotesAttacheCandidates < ActiveRecord::Migration
  def change
  	candidates = {}
  	Models::Vote.all.each do |vote|
  		unless candidates[vote.name].present?
  			candidates[vote.name] = Models::Candidate.find_by_name(vote.name)
		end
		vote.candidate = candidates[vote.name]
		vote.save
  	end
  end
end
