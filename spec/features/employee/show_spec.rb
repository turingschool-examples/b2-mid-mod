require 'rails_helper'

RSpec.describe 'Employee Show Page', type: :feature do
 describe 'As a User' do
  before(:each) do
    @department_1 = Department.create(name: "HR", floor: "2")
    @department_2 = Department.create(name: "IT", floor: "1")

    @employee_1 = @department_2.employees.create!(name: "Laura Vega", level: "Junior")
    @employee_2 = @department_1.employees.create!(name: "Mark Mars", level: "Senior")
    @employee_3 = @department_2.employees.create!(name: "Libby Row", level: "Senior")
    @employee_4 = @department_1.employees.create!(name: "Julianne Drak", level: "Junior")

    @ticket_1 = @employee_3.tickets.create!(subject: "Protect application form changes in db", age: 5)
    @ticket_2 = @employee_3.tickets.create!(subject: "Maintainance to failure Feb16", age: 1)
    @ticket_3 = @employee_3.tickets.create!(subject: "Refactor Astronaut's features", age: 8)
    @ticket_4 = Ticket.create!(subject: "Maintain Missions", age: 0)
  end

  #User Story #2
  it 'displays employee name, department, and list of the tickets it has assigned' do
    # As a user,
    # When I visit the Employee show page,
    visit "/employees/#{@employee_3.id}"
save_and_open_page
    # I see the employee's name, their department,
    expect(page).to have_content("Name: Libby Row")
    # and a list of all of their tickets from oldest to newest.
    within ".tick_assigned" do
      expect(page).to have_content("Tickets Assigned:")
      expect("Refactor Astronaut's features").to appear_before("Protect application form changes in db")
      expect("Protect application form changes in db").to appear_before("Maintainance to failure Feb16")
      within "#oldest_ticket" do
        # I also see the oldest ticket assigned to the employee listed separately.
        expect(page).to have_content("Oldest Ticket: Refactor Astronaut's features")
      end
    end
  end

  #User Story #3
  it "displays a form if no tickets are assigned and succesfully adds ticket" do
    # As a user,
    # When I visit the employee show page,
    visit "/employees/#{@employee_1.id}"
    
    # I do not see any tickets listed that are not assigned to the employee
    expect(page).to_not have_content("Tickets Assigned:")

    # and I see a form to add a ticket to this employee.
    expect(page).to have_content("Add a ticket to this employee")
    
    # When I fill in the form with the id of a ticket that already exists in the database
    fill_in("ticket_id", with: @ticket_4.id)
    # and I click submit
    click_button("Submit")
   
    # Then I am redirected back to that employees show page
    expect(current_path).to eq("/employees/#{@employee_1.id}")
    
    # and I see the ticket's subject now listed.
    expect(page).to have_content("Tickets Assigned:")
    expect(page).to have_content("Maintain Missions")
    # (you do not have to test for sad path, for example if the id does not match an existing ticket.)
  end
 end
end