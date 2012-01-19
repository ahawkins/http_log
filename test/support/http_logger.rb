class ActiveSupport::TestCase
  setup :clear_callbacks

  def clear_callbacks
    HttpLog.callbacks.clear
  end
end
