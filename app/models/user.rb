class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :groups, through: :user_groups
  has_many :user_groups

  validates :name, presence: true, length: { maximum: 6 }

  scope :exclude, ->(user) { where.not(id: user.id) }
end
