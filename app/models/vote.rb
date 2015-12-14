require 'ipaddr'

module Models
	class Vote < ActiveRecord::Base
		TYPE_PRO = 'pro'
		TYPE_CONTRA = 'contra'
		TYPE_WHO = 'who'
		TYPE_APPROVES = 'approves'
		TYPE_DISAPPROVES = 'disapproves'


		def self.pro(name, ip)
			Vote._vote(name, TYPE_PRO, ip)
		end

		def self.contra(name, ip)
			Vote._vote(name, TYPE_CONTRA, ip)
		end

		def self.who(name, ip)
			Vote._vote(name, TYPE_WHO, ip)
		end

		def self.approves(ip)
			Vote._vote('', TYPE_APPROVES, ip)
			Vote._agreggated_votes
		end

		def self.disapproves(ip)
			Vote._vote('', TYPE_DISAPPROVES, ip)
			Vote._agreggated_votes_approve
		end

		def self._vote(name, subject, ip)
			data = {
					:name => name,
					:subject => subject,
					:ammount => 1,
					:ip => Vote.ip_addr(ip)
				}
			vote = Vote.find_by(data) || Vote.create(data)
			vote.save!
		end

		def self.ip_addr(ip)
			ipAddr = IPAddr.new ip
			ipAddr.to_i
		end
		def self._agreggated_votes_approve()
			approves = 0
			disapproves = 0
			Vote.where("subject = ? OR subject = ?", TYPE_APPROVES, TYPE_DISAPPROVES).each do |vote|
				if vote.subject == TYPE_APPROVES
					approves = approves + 1
				else
					disapproves = disapproves + 1
				end
			end
			{:approves => approves, :disapproves => disapproves}
		end
		def self._agreggated_votes_procontra()
			pro = 0
			contra = 0
			Vote.where("subject = ? OR subject = ?", TYPE_PRO, TYPE_CONTRA).each do |vote|
				if vote.subject == TYPE_PRO
					pro = pro + 1
				else
					contra = contra + 1
				end
			end
			{:pro => pro, :contra => contra}
		end
	end
end