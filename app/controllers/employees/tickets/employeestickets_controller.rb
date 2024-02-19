class Employees::Tickets::EmployeesticketsController < ApplicationController

  def create
    EmployeeTicket.create!(ticket_id: params[:ticket_id], employee_id: params[:id])

    redirect_to "/employees/#{params[:id]}"
  end
end