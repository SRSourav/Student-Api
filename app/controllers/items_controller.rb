class ItemsController < ApplicationController
before_action :set_student
  before_action :set_student_item, only: [:show, :update, :destroy]

  # GET /todos/:todo_id/items
  def index
    json_response(@student.items)
  end

  # GET /todos/:todo_id/items/:id
  def show
    json_response(@item)
  end

  # POST /todos/:todo_id/items
  def create
    @student.items.create!(item_params)
    json_response(@student, :created)
  end

  # PUT /todos/:todo_id/items/:id
  def update
    @item.update(item_params)
    head :no_content
  end

  # DELETE /todos/:todo_id/items/:id
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :done)
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_student_item
    @item = @student.items.find_by!(id: params[:id]) if @student
  end
end