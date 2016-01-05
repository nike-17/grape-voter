require 'mailgun'


module Models
	class Propose
		def self.send(name)

			message = <<MESSAGE_END
From: Putin Io  <info@putin.io>
To: Putin Io  <info@putin.io>
Subject: Nominated Candiate

#{name}
MESSAGE_END
			mg_client = Mailgun::Client.new "56714e2ca0793bb8d9f83f11e0bc25b6"

			message_params = {:from    => 'info@putin.io',
                  :to      => 'nike-17@ya.ru',
                  :subject => ' Nominated Candiate',
                  :text    => message}

# Send your message through the client
mg_client.send_message "sending_domain.com", message_params



		
		end

	end
end