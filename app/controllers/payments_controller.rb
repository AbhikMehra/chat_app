class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    amount = params[:amount].to_i * 100 # Razorpay works in paise

    order = Razorpay::Order.create(
      amount: amount,
      currency: "INR",
      receipt: "chat_app_#{Time.now.to_i}"
    )

    payment = current_user.payments.create!(
      amount: amount,
      razorpay_order_id: order.id,
      status: "created"
    )

    render json: {
      order_id: order.id,
      key: ENV["RAZORPAY_KEY_ID"],
      amount: amount
    }
  end

  def verify
    payment = Payment.find_by(razorpay_order_id: params[:razorpay_order_id])

    attributes = {
      razorpay_order_id: params[:razorpay_order_id],
      razorpay_payment_id: params[:razorpay_payment_id],
      razorpay_signature: params[:razorpay_signature]
    }

    Razorpay::Utility.verify_payment_signature(attributes)

    payment.update!(
      razorpay_payment_id: params[:razorpay_payment_id],
      razorpay_signature: params[:razorpay_signature],
      status: "paid"
    )

    redirect_to root_path, notice: "Payment Successful 🎉"
  rescue
    redirect_to root_path, alert: "Payment Failed"
  end
end