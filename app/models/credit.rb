class Credit < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def update_total_credit
    this = self
    total_credit = this.free_credit + this.purchased_credit
    this.update_attributes(total_credit: total_credit)
  end

  def can_bet?(amount, lucky_number)
    if self.total_credit >= amount && lucky_number.between?(1,99)
      substract_from_credit(amount)
      true
    else
      false
    end
  end

  def substract_from_credit(amount)
    remaining_credit = self.free_credit - amount

    if remaining_credit <= 0
      subtract_from_purchased_credit(remaining_credit.abs)
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

  def subtract_from_purchased_credit(amount)
    remaining_credit = self.purchased_credit - amount
    self.update_attributes(purchased_credit: remaining_credit)
    self.transactions.create!(
      credit_id: self.id,
      description: "Subtracted ₱#{amount} from your purchased_credit"
    )
  end

  def subtract_from_free_credit(remaining_credit, amount)
    self.update_attributes(free_credit: remaining_credit)
    self.transactions.create(credit_id: self.id, description: "Subtracted ₱#{amount} from your free credit")
  end
end
