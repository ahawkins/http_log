module HttpLogger
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :include_http_request_log_id

      def include_http_request_log_id
        headers['X-Request-Log-ID'] = request.env['http_logger.request_id']
      end
    end
  end
end
