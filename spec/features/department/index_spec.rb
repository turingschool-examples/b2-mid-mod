require 'rails_helper'

RSpec.describe 'Department Index Page', type: :feature do
 describe 'As a User' do
  before(:each) do
    @department_1 = Department.create(name: "HR", floor: "2")
    @department_2 = Department.create(name: "IT", floor: "1")

    @employee_1 = @department_2.employees.create!(name: "Laura Vega", level: "Junior")
    @employee_2 = @department_1.employees.create!(name: "Mark Mars", level: "Senior")
    @employee_3 = @department_2.employees.create!(name: "Libby Row", level: "Senior")
    @employee_4 = @department_1.employees.create!(name: "Julianne Drak", level: "Junior")
  end

  #User Story 1
  it 'displays each departments name, floor and list of employees' do
    # As a user,
    # When I visit the Department index page,
    visit "/departments"

    within ".department-#{@department_1.id}" do
      # I see each department's name and floor
      expect(page).to have_content("Department Name: HR")
      expect(page).to have_content("Floor: 2")
      # And underneath each department, I can see the names of all of its employees
      expect(page).to have_content("Mark Mars")
      expect(page).to have_content("Julianne Drak")
    end
    
    within ".department-#{@department_2.id}" do
      # I see each department's name and floor
      expect(page).to have_content("Department Name: IT")
      expect(page).to have_content("Floor: 1")
      expect(page).to have_content("Department's Employees:")
      # And underneath each department, I can see the names of all of its employees
      expect(page).to have_content("Laura Vega")
      expect(page).to have_content("Libby Row")
    end
  end
 end
end