module HttpLogger
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :include_http_request_log_id

      def include_http_request_log_id
        return unless http_logger_request_id.present?
        logger.info "  HTTP Logger Request ID: #{http_logger_request_id}"
        headers['X-Request-Log-ID'] = http_logger_request_id
      end

      def http_logger_request_id
        request.env['http_logger.request_id']
      end
    end
  end
end
