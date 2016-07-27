module ApplicationHelper
  def credits
    current_user.credit.free_credit + current_user.credit.purchased_credit
  end
end
