class User < ApplicationRecord

    mount_uploader :image, ImagesUploader

    validates :name, presence: true, length: {maximum: 10 }
    validates :email, presence: true, length: {maximum: 30 },
                      format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: {case_sensitive: false}

has_secure_password
   has_many :products
   has_many :messages, dependent: :destroy
   has_many :entries, dependent: :destroy
   has_many :rooms, dependent: :destroy

   has_many :favorites, dependent: :destroy
   has_many :likes, through: :favorites, source: :product

   has_many :reviews, dependent: :destroy
   has_many :evaluates, through: :reviews, source: :product

   has_many :posts

   has_many :microposts

   has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
   has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
   has_many :notifications, dependent: :destroy


  def favorite(product)
      self.favorites.find_or_create_by(product_id: product.id)
  end

  def unfavorite(product)
    favorite = self.favorites.find_by(product_id: product.id)
    favorite.destroy if favorite
  end

  def favoriting?(product)
    self.likes.include?(product)
  end

  def review(product)
    self.reviews.find_or_create_by(product_id: product.id)
  end

  def reviewing?(product)
    self.evaluates.include?(product)
  end

  def feed_products
    Product.all
  end


end
