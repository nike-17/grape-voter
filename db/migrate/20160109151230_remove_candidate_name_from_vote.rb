class RemoveCandidateNameFromVote < ActiveRecord::Migration
  def change
  	candidates = {}
  	Models::Vote.where("(subject = 'pro' or subject = 'contra') and candidate_id is null").each do |vote|
  		unless candidates[vote.name].present?
  			candidates[vote.name] = Models::Candidate.find_by_name(vote.name)
		end
		if candidates[vote.name].present?
			vote.candidate_id = candidates[vote.name]
			vote.save
		else 
			puts vote.name 
			puts vote.subject
			# vote.destroy
		end

  	end
  	remove_column :votes, :name
  end
end
