require 'json'

namespace :data do
  
  task :environment do
    require_relative '../../config/environment'
  end
  
  desc 'Generate top file'
  task :generate_top => :environment do
  	File.open("/www/putin.io/data/top.json","w") do |f|
  		top = Models::Vote.top
  		top.each do |key, array|
  			top[key]  = array.map { |e|  
  				{:name => e.candidates.name.force_encoding("UTF-8"), :count => e.ammount_sum}

  			} 
        end 
      f.write(top.to_json)  
		end
  end

  desc 'Generate candidates file'
  task :generate_candidates => :environment do
    File.open("/www/putin.io/data/candidates.json","w") do |f|

      candidates = Models::Candidate.all.to_a.map { |e|  
        {:name => e.name.force_encoding("UTF-8"), :description => e.description.force_encoding("UTF-8"), :image => e.image, :id => e.id}
      } 

      f.write(candidates.to_json)
    end
  end



  desc 'Attach Votes to Candidates'
  task :votes2candidates => :environment do
    candidates = {}
    Model::Votes.all.each do |vote|
      unless candidates[vote.name].present?
        candidates[vote.name] = Model::Candidates.find_by_name(vote.name)
    end
    vote.candidate = candidates[vote.name]
    vote.save
    end
  end

end