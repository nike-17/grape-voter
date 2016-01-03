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
      	requires :name, type: String, desc: ''
      end	
      post :pro do
        Models::Vote.pro(params[:name], client_ip)
      end
      post :contra do
       	Models::Vote.contra(params[:name], client_ip)
      end
      post :who do
        Models::Vote.who(params[:name], client_ip)
      end

      post :approves do
        Models::Vote.approves(client_ip)
      end
      post :disapproves do
        Models::Vote.disapproves(client_ip)
      end
      post :top do
        cache = ActiveSupport::Cache::MemoryStore.new
        top = cache.read('top')
        unless top
           top = Models::Vote.top
           cache.write('top', top)
        end
        top
      end
    end
  end
end