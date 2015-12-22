class VisitGroup < ActiveRecord::Base
  self.per_page = Visit.per_page

  has_paper_trail
  acts_as_paranoid
  acts_as_list scope: [:arm_id]

  include CustomPositioning #custom methods around positioning, acts_as_list

  belongs_to :arm

  has_many :visits, dependent: :destroy
  has_many :line_items, through: :arm
  has_many :appointments

  before_destroy :check_arm_visit_count
  after_destroy :decrement_visit_count
  after_destroy :remove_appointments

  default_scope {order(:position)}

  validates :arm_id,
            :name,
            presence: true

  validates :day, presence: true, unless: "ENV.fetch('USE_EPIC'){nil} == 'false'"
  validates :day, numericality: true, if: "self.day.present?"

  def r_quantities_grouped_by_service
    visits.joins(:line_item).group(:service_id).sum(:research_billing_qty)
  end

  def t_quantities_grouped_by_service
    visits.joins(:line_item).group(:service_id).sum(:insurance_billing_qty)
  end


  private

  def check_arm_visit_count
    if arm.visit_count == 1
      self.errors[:base] << "Arm must have at least one visit. Add another visit before deleting this one"
      return false
    end
  end

  def decrement_visit_count
    arm.decrement(:visit_count)
  end

  def remove_appointments
    appointments.each{|appointment| appointment.try(:destroy)}
  end
end
