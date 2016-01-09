class RemoveCandidateNameFromVote < ActiveRecord::Migration
  def change
  	candidates = {}
  	Models::Vote.where("subject = 'pro' or subject = 'contra' and candidate_id is null").each do |vote|
  		unless candidates[vote.name].present?
  			candidates[vote.name] = Models::Candidate.find_by_name(vote.name).id
		end
		puts candidate.name
		vote.candidate_id = candidates[vote.name]
		vote.save
  	end
  	remove_column :votes, :name
  end
end
