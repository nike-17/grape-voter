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
  				{:name => e.candidate.name.force_encoding("UTF-8"), :count => e.ammount_sum, :id => e.candidate.id}
  			} 
        end 
      f.write(top.to_json)  
		end
  end

  desc 'Generate candidate each  stat file'
  task :generate_all => :environment do
    agg = Models::Vote.aggregate_by_date
    result = {}
    agg.each do |item|
      unless result[item['candidate_id']].present?
        result[item['candidate_id']] = {}
      end

      unless result[item['candidate_id']][item['subject']].present?
        result[item['candidate_id']][item['subject']] = {}
      end

      unless result[item['candidate_id']][item['subject']][item['day']].present?
        result[item['candidate_id']][item['subject']][item['day']] = {}
      end
      result[item['candidate_id']][item['subject']][item['day']] = item['ammount_sum']
    end 

    result.each do |candidate_id, content|
      File.open("/www/putin.io/data/candidate/#{candidate_id}.json","w") do |f|
        f.write(content.to_json) 
      end 
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

end