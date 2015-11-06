module Models
	class Vote < ActiveRecord::Base
		TYPE_PRO = 'pro'
		TYPE_CONTRA = 'contra'
		TYPE_WHO = 'who'
		TYPE_APPROVES = 'approves'
		TYPE_DISAPPROVES = 'disapproves'


		def self.pro(name)
			Vote._vote(name, TYPE_PRO)
		end

		def self.contra(name)
			Vote._vote(name, TYPE_CONTRA)
		end

		def self.who(name)
			Vote._vote(name, TYPE_WHO)
		end

		def self.approves()
			Vote._vote('', TYPE_APPROVES)
		end

		def self.disapproves()
			Vote._vote('', TYPE_DISAPPROVES)
		end

		def self._vote(name, subject)
			Vote.create(
				{
					:name => name,
					:subject => subject,
					:ammount => 1
				}
			)
		end
	end
end