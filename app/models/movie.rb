class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  validates_presence_of :title, :release_date, :director, :genre
  validates_uniqueness_of :title

  def number_of_ratings
    reviews.count
  end

  def average_rating
    reviews.map(&:rating).sum/reviews.count rescue 0.0
  end

end