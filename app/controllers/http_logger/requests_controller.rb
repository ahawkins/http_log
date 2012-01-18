module HttpLogger
  class RequestsController < ActionController::Base
    respond_to :xml, :json

    def show
      respond_with HttpLogger::Request.find(params[:id])
    end
  end
end
