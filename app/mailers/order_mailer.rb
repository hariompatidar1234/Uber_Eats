class OrderMailer < ApplicationMailer

  def order_confirm(user)
    @user = user
    mail(to: @user.email, subject: 'Order confirm TO Uber_Eats !!')
  end

  # def notify_owner(order_id, owner_email)
  #   @order = Order.find(order_id)
  #   mail(to: owner_email, subject: 'New Order Notification')
  # end
end
