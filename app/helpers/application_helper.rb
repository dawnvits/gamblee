module ApplicationHelper
  def credits
    current_user.credit.free_credit + current_user.credit.game_credit
  end

  def user_name(id)
    "#{User.find(id).first_name} #{User.find(id).last_name}"
  end
end
