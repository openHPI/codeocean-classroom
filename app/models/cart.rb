# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_exercises, dependent: :destroy
  has_many :exercises, through: :cart_exercises

  validates :user, presence: true

  def self.find_cart_of(user)
    cart = find_by(user: user)
    cart || create(user: user)
  end

  def add_exercise(exercise)
    exercises << exercise unless exercises.find_by(id: exercise.id)
  end

  def remove_exercise(exercise)
    exercises.delete(exercise)
  end

  def remove_all
    exercises.each do |exercise|
      exercises.delete(exercise)
    end
  end
end
