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
  				{:name => e.name.force_encoding("UTF-8"), :count => e.ammount_sum}

  			} 
        end 
      f.write(top.to_json)  
		end
  end

  desc 'Generate candidates file'
  task :generate_candidates => :environment do
    File.open("/www/putin.io/data/candidates.json","w") do |f|

      candidates = Models::Candidate.all
      candidates.each do |key, array|
        candidates[key]  = array.map { |e|  
          {:name => e.name.force_encoding("UTF-8"), :description => e.description, :image => e.image}
        } 
        end 

      f.write(candidates.to_json)
    end
  end

end