class EmployeesController < ApplicationController

  def show 
    @employee = Employee.find(params[:id])
    @no_tickets = @employee.tickets == [] 
  end
end