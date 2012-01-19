class ActiveSupport::TestCase
  setup :clear_callbacks

  def clear_callbacks
    HttpLogger.callbacks.clear
  end
end
