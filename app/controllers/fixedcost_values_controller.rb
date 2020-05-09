class FixedcostValuesController < ApplicationController
  def index
    @fixedcosts = Fixedcost.order(created_at: :asc)
    @fixedcost_values = FixedcostValue.order(year_month: :asc)
  end

  def show
    @fixedcost_value = FixedcostValue.find(params[:id])
  end

  def new
    year_month_day = params[:year_month] + "-01"
    @year_month = year_month_day.to_date

    @fixedcosts = Fixedcost.order(created_at: :asc)
    @form = Form::FixedcostForm.new
  end

  def edit
    @fixedcost_value = FixedcostValue.find(params[:id])
    @fixedcost = Fixedcost.find(@fixedcost_value.fixedcost_id)
  end

  def create
    @form = Form::FixedcostForm.new(fixedcost_form_params)
    if @form.save
      redirect_to :fixedcost_values, notice: "登録しました"
    else
      redirect_to :fixedcost_values, notice: "登録に失敗しました"
    end
  end

  def update
    @fixedcost_value = FixedcostValue.find(params[:id])
    @fixedcost_value.assing_attributes(params[:fixedcost_value])
    if @fixedcost_value.save
      redirect_to :fixedcost_values, notice: "情報を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @fixedcost_value = FixedcostValue.find(params[:id])
    @fixedcost_value.destroy
    redirect_to :fixedcost_values, notice: "データを削除しました"
  end

  private

  def fixedcost_form_params
    params.require(:form_fixedcost_form).permit(fixedcost_values_attributes: Form::FixedcostValue::REGISTRABLE_ATTRIBUTES)
  end
end
