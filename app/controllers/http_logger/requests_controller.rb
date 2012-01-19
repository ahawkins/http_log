module HttpLogger
  class RequestsController < ActionController::Base
    respond_to :html, :xml, :json

    def show
      @log = HttpLogger::Request.find params[:id]
      respond_with @log
    end
  end
end
