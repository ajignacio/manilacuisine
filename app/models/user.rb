class User < ActiveRecord::Base
  #before_action :authenticate_user!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :first_name, :last_name, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }
  ROLES = ['guest', 'admin', 'member']
  ROLES.each do |role|
     self.send :define_method, "promote_to_#{role.parameterize.underscore.to_sym}!",lambda { update_column(:role, role.to_s.downcase) }
     self.send :define_method, "is_#{role.parameterize.underscore.to_sym}?", lambda { self.role.eql? role.to_s.downcase }
  end

  def has_full_access?
    (is_admin? or is_guest? or is_member?)
  end

  def self.is_admin?
   user.role == 'admin'
  end

  def self.is_guest?
    user.role == 'guest'
  end

  def self.is_member?
    user.role == 'member'
  end


end
