class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def check_rate_of_limit(parsed_resp)
    if parsed_resp['message']
      render 'source/client_error', locals: { message: parsed_resp['message'] }
      false
    else
      true
    end
  end
end
