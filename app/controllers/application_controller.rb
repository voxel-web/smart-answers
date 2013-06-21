require "slimmer/headers"

class ApplicationController < ActionController::Base
  include Slimmer::Headers
  before_filter :set_analytics_headers

  rescue_from GdsApi::TimedOutException, :with => :error_503

protected
  def error_503(e = nil); error(503, e); end

  def error(status_code, exception = nil)
    render :status => status_code, :text => "#{status_code} error"
  end

  def set_analytics_headers
    set_slimmer_headers(format: "smart_answer")
  end

  def set_expiry(duration = 30.minutes)
    unless Rails.env.development?
      expires_in(duration, :public => true)
    end
  end
end
