require 'geoip'
require 'ipaddr'

class AttacheIpData < ActiveRecord::Migration
  def change
  	geo = GeoIP.new('./data/GeoLiteCity.dat')
  	Models::Vote.all.each do |vote|
  		ip = IPAddr.new(vote.ip ,Socket::AF_INET)
  		data = geo.city(ip)
  		if data.present?
	  		if data.city_name.present?
	  			vote.city_name = data.city_name
	  		end
	  		if data.real_region_name.present?
	  			vote.real_region_name = data.real_region_name
	  		end

	  		if data.country_name.present?
	  			vote.country_name = data.country_name
	  		end

	  		if data.latitude.present?
	  			vote.latitude = data.latitude
	  		end

	  		if data.longitude.present?
	  			vote.longitude = data.longitude
	  		end

	  		vote.save
  		end
  	end
  end
end
