class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable

        #  :trackable,　これはずしてみた

  has_many :books,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorite, source: :book
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence:true,length: {maximum: 20, minimum: 2}
  validates :email, uniqueness: true
  validates :introduction,length:{maximum:50}

  # has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # すでにいいねした確認
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
end
