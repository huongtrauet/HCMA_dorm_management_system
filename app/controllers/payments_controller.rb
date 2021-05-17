class PaymentsController < ApplicationController
  def new
  end

  def create
    environment = PayPal::SandboxEnvironment.new(ENV['CLIENT_ID'], ENV['SECRET'])
    client = PayPal::PayPalHttpClient.new(environment)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new(params[:order_id])
    begin
      # Call API with your client and get a response for your call
      response = client.execute(request)

      # If call returns body in response, you can get the deserialized version from the result attribute of the response
      order = response.result
      Payment.create order_id: order.id, payer_id: order.payer.payer_id
    rescue PayPalHttp::HttpError => ioe
      # Something went wrong server-side
      puts ioe.status_code
      puts ioe.headers["debug_id"]
    end
  end
end
