class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_acceptance_of :terms, :allow_nil => false, :accept => "1", :on => :create, :message =>"You need to accept our terms and conditions"
  before_save :ensure_authentication_token


  def has_role?(role)
      false       #return !!self.roles.find_by_name(role.to_s.camelize)
  end



  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
