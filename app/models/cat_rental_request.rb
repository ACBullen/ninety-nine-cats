# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :status, presence: true, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :no_overlap


  def no_overlap
    if self.overlapping_requests.length > 0
      errors[:start_date] << "Cannot overlap with another request"
    end
  end

  def overlapping_requests
    start = Cat.find_by(id: self.cat_id).rentals.where(start_date: (self.start_date..self.end_date))
    ending = Cat.find_by(id: self.cat_id).rentals.where(end_date: (self.start_date..self.end_date))
    start.where(status: 'APPROVED') + ending.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    start = Cat.find_by(id: self.cat_id).rentals.where(start_date: (self.start_date..self.end_date))
    ending = Cat.find_by(id: self.cat_id).rentals.where(end_date: (self.start_date..self.end_date))
    start.where(status: "PENDING") + ending.where(status: "PENDING")
  end

  def approve!
    ActiveRecord::Base.transaction do
      if self.valid?
        conflicts = self.overlapping_pending_requests
        conflicts.each do |conflict|
          conflict.deny!
        end
        self.status = 'APPROVED'
        self.save
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save
  end
  def pending?
    return true if self.status =='PENDING'

    false
  end
  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat
end
