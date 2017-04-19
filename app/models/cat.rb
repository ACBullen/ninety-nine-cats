# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
  COLORS = ['grey', 'calico', 'black', 'white', 'rainbow', 'ultraviolet']
  validates :birth_date, presence: true
  validates :color, presence: true, inclusion: { in: COLORS, message: "Please select a valid cat color." }
  validates :name, presence: true
  validates :sex, presence: true, inclusion: { in: ['M', 'F'] }
  validates :description, presence: true


  def age
    today = Date.today

    (today.year - self.birth_date.year)
  end

  has_many :rentals,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

end
