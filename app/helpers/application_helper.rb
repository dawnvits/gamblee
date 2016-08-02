module ApplicationHelper
  def credits
    current_user.credit.free_credit + current_user.credit.purchased_credit
  end

  def username(id)
    User.find(id).name
  end
end
