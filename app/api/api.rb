module Api
  class Vote < Grape::API
    use ActionDispatch::RemoteIp
    version 'v1', :using => :header, :vendor => 'acme', :format => :json
    helpers do
      def client_ip
        env['action_dispatch.remote_ip'].to_s
      end
    end

    resource :vote do
      desc "vote pro"
      params do
        requires :candidate_id, type: Integer, desc: ''

      end	
      post :pro do
        Models::Vote.pro(params[:candidate_id], client_ip)
      end
      post :contra do
       	Models::Vote.contra(params[:candidate_id], client_ip)
      end
      post :who do
        Models::Vote.who(params[:candidate_id], client_ip)
      end

      post :approves do
        Models::Vote.approves(client_ip)
      end
      post :disapproves do
        Models::Vote.disapproves(client_ip)
      end

      post :propose do
          Models::Propose.send(params[:name])
      end
    end
    resource :candidate do
      get :all do
        Models::Candidate.all.to_a.map(&:serializable_hash)
      end
    end
  end
end