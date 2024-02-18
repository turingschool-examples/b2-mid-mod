require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe "Instance methods" do
    describe "#org_tickets" do
      it "returns tickes organized from oldest to newest" do
        @department_1 = Department.create!(name: "IT", floor: "1")

        @employee_1 = @department_1.employees.create!(name: "Laura Vega", level: "Junior")

        @ticket_1 = @employee_1.tickets.create!(subject: "Protect application form changes in db", age: 5)
        @ticket_2 = @employee_1.tickets.create!(subject: "Maintainance to failure Feb16", age: 1)
        @ticket_3 = @employee_1.tickets.create!(subject: "Refactor Astronaut's features", age: 8)
        
        expect(@employee_1.org_tickets.first).to eq(@ticket_3)
        expect(@employee_1.org_tickets.last).to eq(@ticket_2)
      end
    end
  end
end