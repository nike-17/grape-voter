class RemoveCandidatesWithoutConnection < ActiveRecord::Migration
  def change
  	Models::Vote.where("(subject = 'pro' or subject = 'contra') and candidate_id is null").destroy_all
  end
end
