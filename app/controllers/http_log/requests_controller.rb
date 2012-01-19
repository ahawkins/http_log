module HttpLog
  class RequestsController < ActionController::Base
    respond_to :html, :xml, :json

    def show
      @log = HttpLog::Request.find params[:id]
      respond_with @log
    end
  end
end
