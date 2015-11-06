module Api
  class Vote < Grape::API
    version 'v1', :using => :header, :vendor => 'acme', :format => :json
    resource :vote do
      desc "vote pro"
      params do
      	requires :name, type: String, desc: ''
      end	
      post :pro do
        Models::Vote.pro(params[:name])
      end
      post :contra do
       	Models::Vote.contra(params[:name])
      end
      post :who do
        Models::Vote.who(params[:name])
      end

      post :approves do
        Models::Vote.approves
      end
      post :disapproves do
        Models::Vote.disapproves
      end
    end
    add_swagger_documentation
  end
end