class CheckoutsController < ApplicationController
  protect_from_forgery except: [:create]
  
  def create
    response = validate_IPN_notification(request.raw_post)
    if response == "VERIFIED"
      if params[:payment_status] == "Completed"
        PaymentNotification.create!(payer_email: params[:payer_email], txn_id: params[:txn_id], ipn_track_id: params[:ipn_track_id], mc_gross: params[:mc_gross])
        User.find_by_paypal_email(params[:payer_email]).credit.purchase_credits(params[:mc_gross].to_i)
      end
    end
    render nothing: true
  end 
  
  protected
  
  def validate_IPN_notification(raw)
    uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate')
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, raw,
      'Content-Length' => "#{raw.size}",
      'User-Agent' => 'Lucky Ending'
    ).body
  end
end
