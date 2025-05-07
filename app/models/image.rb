class Image < ApplicationRecord
  
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Image.where(title: content)
    elsif method == 'forward'
      Image.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Image.where('title LIKE ?', '%'+content)
    else
      Image.where('title LIKE ?', '%'+content+'%')
    end
  end
end
