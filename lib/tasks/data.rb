require 'json'

namespace :data do
  task :environment do
    require_relative '../../config/environment'
  end
  desc 'Generate top file'
  task :generate_top => :environment do
  	File.open("/www/putin.io/data/top.json","w") do |f|
  		f.write(Models::Vote.top.to_json)
	end
  end 
end
