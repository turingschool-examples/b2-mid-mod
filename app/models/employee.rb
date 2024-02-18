class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def org_tickets
    tickets.order(age: :desc)
  end
end