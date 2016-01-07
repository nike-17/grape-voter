require "net/https"  
require "uri"
require File.expand_path('../../../config/mail', __FILE__)

module Models
	class Propose
		def self.send(name)

			message = <<MESSAGE_END
From: Putin Io  <info@putin.io>
To: Putin Io  <info@putin.io>
Subject: Nominated Candiate

#{name}
MESSAGE_END
			uri = URI.parse("https://api.mailgun.net/v2/putin.io/messages")

		
			message_params = {:from    => 'info@putin.io',
                  :to      => 'nike-17@ya.ru',
                  :subject => 'Nominated Candiate',
                  :text    => message}

			http = Net::HTTP.new(uri.host, uri.port)  
			http.use_ssl = true

			request = Net::HTTP::Post.new(uri.request_uri)  
			request.basic_auth("api", Config::MAILGUN_API_KEY)  
			request.set_form_data(message_params)

			response = http.request(request)  

		end

	end
end