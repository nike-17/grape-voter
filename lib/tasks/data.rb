require 'json'
require 'sitemap_generator'


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
    aggregatedAll = Models::Vote.agreggated_all_votes_procontrawho
    agg.each do |item|
      unless result[item['candidate_id']].present?
        result[item['candidate_id']] = {}
      end

      unless result[item['candidate_id']]['pro'].present?
        result[item['candidate_id']]['pro'] = {}
      end

        unless result[item['candidate_id']]['contra'].present?
        result[item['candidate_id']]['contra'] = {}
      end

        unless result[item['candidate_id']]['who'].present?
        result[item['candidate_id']]['who'] = {}
      end

      unless result[item['candidate_id']]['pro'][item['day']].present?
        result[item['candidate_id']]['pro'][item['day']] = 0
      end 

      unless result[item['candidate_id']]['contra'][item['day']].present?
        result[item['candidate_id']]['contra'][item['day']] = 0
      end

      unless result[item['candidate_id']]['who'][item['day']].present?
        result[item['candidate_id']]['who'][item['day']] = 0
      end
        
      result[item['candidate_id']][item['subject']][item['day']] = item['ammount_sum']
      result[item['candidate_id']][:candidate] =   {:name => item.candidate.name.force_encoding("UTF-8"), :description => item.candidate.description.force_encoding("UTF-8"), :image => item.candidate.image, :id => item.candidate.id}
      result[item['candidate_id']][:stat] = aggregatedAll[item['candidate_id']]
    end 

    result.each do |candidate_id, content|
      File.open("temp/#{candidate_id}.json","w") do |f|
        f.write(content.to_json) 
      end 
    end
  end

  desc 'Generate sitemap'
  task :generate_sitemap => :environment do
    SitemapGenerator::Sitemap.default_host = 'http://putin.io'
    SitemapGenerator::Sitemap.public_path = '/www/putin.io/'
    SitemapGenerator::Sitemap.compress = false
    SitemapGenerator::Sitemap.create do
      add '/', :changefreq => 'daily', :priority => 0.9
      for i in 1..97
        add "/who/#{i}", :changefreq => 'weekly'
      end
      
    end
  end

  desc 'Generate candidates file'
  task :generate_candidates => :environment do
    File.open("/www/putin.io/data/candidates.json","w") do |f|

      aggregatedAll = Models::Vote.agreggated_all_votes_procontrawho
      candidates = Models::Candidate.all.to_a.map { |e|  
        {:name => e.name.force_encoding("UTF-8"), :description => e.description.force_encoding("UTF-8"), :image => e.image, :id => e.id, :stat => aggregatedAll[e.id]}
      } 

      f.write(candidates.to_json)
    end
  end

end