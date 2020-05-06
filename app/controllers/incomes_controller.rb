class IncomesController < ApplicationController
  def index
    @incomes = Income.order(created_at: :asc)
  end

  def show
    @income = Income.find(params[:id])
  end

  def new
    @income = Income.new()
  end

  def edit
    @income = Income.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
