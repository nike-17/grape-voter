require 'json'

namespace :data do
  task :environment do
    require_relative '../../config/environment'
  end
  desc 'Generate top file'
  task :generate_top => :environment do
  	File.open("/www/putin.io/data/top.json","w") do |f|
  		f.write(JSON.generate(Models::Vote.top))
	end
  end 
end
