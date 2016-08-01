class User < ApplicationRecord
  has_one :credit
  has_many :bets

  after_commit :create_free_credits, on: :create

  validates :first_name,
            :last_name,
            :email,
            :contact_number, presence: true

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
end
