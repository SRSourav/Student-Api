class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @students = Student.all
    json_response(@students)
  end

  # POST /todos
  def create
    @student = Student.create!(student_params)
    json_response(@student, :created)
  end

  # GET /todos/:id
  def show
    json_response(@student)
  end

  # PUT /todos/:id
  def update
    @student.update(student_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @student.destroy
    head :no_content
  end

  private

  def student_params
    # whitelist params
    params.permit(:full_name, :roll)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end