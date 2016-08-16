class Credit < ApplicationRecord
  belongs_to :user
  has_many :transactions

  attr_accessor :amount

  def update_total_credit
    this = self
    total_credit = this.free_credit + this.game_credit
    this.update_attributes(total_credit: total_credit)
  end

  def can_bet?(amount, lucky_number)
    if self.total_credit >= amount && lucky_number.between?(1, 99)
      substract_from_credit(amount)
      true
    else
      false
    end
  end

  def substract_from_credit(amount)
    remaining_credit = self.free_credit - amount

    if remaining_credit <= 0
      subtract_from_game_credit(remaining_credit.abs)
      self.transactions.create!(
        credit_id: self.id,
        description: "Subtracted ₱#{amount - remaining_credit.abs} from your free credit"
      )
      self.update_attributes(free_credit: 0)
    else
      self.subtract_from_free_credit(remaining_credit, amount)
    end
    update_total_credit
  end

  def subtract_from_game_credit(amount)
    remaining_credit = self.purchased_credit - amount
    self.update_attributes(game_credit: remaining_credit)
    self.transactions.create!(
      credit_id: self.id,
      description: "Subtracted ₱#{amount} from your game_credit"
    )
  end

  def subtract_from_free_credit(remaining_credit, amount)
    self.update_attributes(free_credit: remaining_credit)
    self.transactions.create(credit_id: self.id, description: "Subtracted ₱#{amount} from your free credit")
  end

  def self.update_for_winner(user_id, game_id)
    prize = Bet.where('user_id = ? AND game_id = ?', user_id, game_id).first.amount
    prize = prize * 2
    old_credit = self.where(user_id: user_id).first.game_credit
    new_credit = old_credit + prize

    credit = Credit.where(user_id: user_id).first
    credit.update_attributes(game_credit: new_credit)
    credit.transactions.create!(
      credit_id: c.id,
      description: "Added ₱#{prize} to your credit by winning on #{game.description}"
    )

    game = Game.find(game_id)
    game.update_attributes(winner_determined: true)
    game.game_transactions.create!(
      game_id: g.id,
      description: 'Found winners for game'
    )
  end

  def purchase_credits(amount)
    new_credit = self.game_credit + amount
    self.update_attributes(user_id: user_id, game_credit: new_credit)
    self.transactions.create!(
      credit_id: self.id,
      description: "Added ₱#{amount} to your game_credit Via Paypal"
    )
    update_total_credit
  end
end
