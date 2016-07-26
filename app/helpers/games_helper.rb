module GamesHelper
  def betting_status(args)
    args ? '<i class="green checkmark icon"><i>'.html_safe : '<i class="red remove icon"></i>'.html_safe
  end
end
