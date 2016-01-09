class VotesAttacheCandidatesAgain < ActiveRecord::Migration
  def change
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
  end
end
