class User < ApplicationRecord
  has_one :credit, dependent: :destroy
  has_many :bets, dependent: :destroy

  after_commit :create_free_credits, on: :create
  after_create :set_name

  validates :first_name,
            :last_name,
            :email,
            :contact_number, presence: true, on: :create

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.name = auth.info.name
      user.image = auth.info.image
      user.skip_confirmation!
      user.save! validate: false
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def password_required?
    super && provider.blank?
  end

  def create_free_credits
    Credit.create!(user_id: self.id, free_credit: 100)
    self.credit.update_total_credit
  end

  def new_bet(game_id, game_description, bet_number_1, bet_number_2, amount)
    Bet.create!(
      game_id: game_id,
      user_id: self.id,
      bet_number_1: bet_number_1,
      bet_number_2: bet_number_2,
      amount: amount,
      description: "Your lucky number for #{game_description} is #{bet_number_1}-#{bet_number_2}"
    )
  end

  def set_name
    name = "#{self.first_name} #{self.last_name}"
    self.update_attributes(name: name) if self.name.nil?
  end
end
