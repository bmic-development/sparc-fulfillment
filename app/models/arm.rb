class Arm < ActiveRecord::Base

  has_paper_trail
  acts_as_paranoid

  belongs_to :protocol

  has_many :line_items, dependent: :destroy
  has_many :visit_groups, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :participants

  before_destroy :check_for_appointment_data, prepend: true

  validates :name, presence: true
  validates_numericality_of :subject_count, greater_than_or_equal_to: 1
  validates_numericality_of :visit_count, greater_than_or_equal_to: 1

  private

  def check_for_appointment_data
    #If any procedures are NOT unstarted (have data), we won't delete the arm, and by extension, the appointments or procedures.
    if appointments.map(&:procedures).any?{|procedure| !procedure.unstarted?}
      self.errors[:base] << "This appointment has existing procedure data, and cannot be deleted."
      return false
    end
  end
end
