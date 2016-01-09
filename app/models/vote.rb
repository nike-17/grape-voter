require 'ipaddr'

module Models
	class Vote < ActiveRecord::Base
		belongs_to :candidate

		TYPE_PRO = 'pro'
		TYPE_CONTRA = 'contra'
		TYPE_WHO = 'who'
		TYPE_APPROVES = 'approves'
		TYPE_DISAPPROVES = 'disapproves'


		def self.pro(candidate_id, ip)
				
			Vote._vote_by_id(candidate_id, TYPE_PRO, ip)
			Vote._agreggated_votes_procontra(candidate_id)
		end

		def self.contra(candidate_id, ip)
			Vote._vote_by_id(candidate_id, TYPE_CONTRA, ip)
			Vote._agreggated_votes_procontra(candidate_id)
		end

		def self.who(candidate_id, ip)
			Vote._vote_by_id(candidate_id, TYPE_WHO, ip)
			Vote._agreggated_votes_procontra(candidate_id)
		end

		def self.approves(ip)
			Vote._vote_by_id(nil, TYPE_APPROVES, ip)
			Vote._agreggated_votes_approve
		end

		def self.disapproves(ip)
			Vote._vote_by_id(nil, TYPE_DISAPPROVES, ip)
			Vote._agreggated_votes_approve
		end

		def self.top
			{:pro => self._top_for(TYPE_PRO), :contra=> self._top_for(TYPE_CONTRA), :who=> self._top_for(TYPE_WHO)}
		end

		def self._vote_by_id(candidate_id, subject, ip)
				data = {
					:candidate_id => candidate_id,
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
		
		def self._agreggated_votes_procontra(candidate_id)
			pro = 0
			contra = 0
			who = 0 
			Vote.where("candidate_id = ? and (subject = ? OR subject = ? OR subject = ?)", candidate_id, TYPE_PRO, TYPE_CONTRA, TYPE_WHO).each do |vote|
				if vote.subject == TYPE_PRO
					pro = pro + 1
				elsif vote.subject == TYPE_WHO
					who = who + 1		
				else
					contra = contra + 1
				end
			end
			{:pro => pro, :contra => contra, :who => who}
		end

		def self._top_for(subject)
			Vote.select("sum(ammount) as ammount_sum, candidate_id")
			.where("subject = ?", subject)
			.group('candidate_id')
			.order('ammount_sum DESC')
			.limit(10)
		end
	end
end