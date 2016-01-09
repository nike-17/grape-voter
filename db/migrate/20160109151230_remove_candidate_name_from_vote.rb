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


  	candidates = {}
  	Models::Vote.where("subject = 'pro' or subject = 'contra' and candidate_id is null").each do |vote|
  		name = vote.name
  		name =  name.gsub ',', '_'
  		name = name.gsub ' ', '_'

  		puts name;
  		unless candidates[name].present?
  			candidates[name] = Models::Candidate.where("name LIKE :name", name: name).first
		end
		vote.candidate = candidates[name]
		vote.save
	end


  	# remove_column :votes, :name
  end
end
