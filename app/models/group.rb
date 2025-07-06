class Group < ApplicationRecord
  has_one_attached :image
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships, source: :user
  # has_many :group_requests
  # has_many :requesting_users, through: :group_requests, source: :user

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

  def includes_user?(user)
    group_users.exists?(user_id: user.id)
  end
end
