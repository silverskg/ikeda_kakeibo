class BalanceConfirmController < ApplicationController
  def top
  end

  def show
    @year_month = params[:year_month] + "-01"
      @incomes = Income.order(created_at: :asc)
      @fixedcosts = Fixedcost.order(created_at: :asc)
      @variablecosts = Variablecost.order(created_at: :asc)

      #収入計算
      @income_values = IncomeValue.where(year_month: @year_month)
      @income_value_total = 0 
      @income_values.each do |income_value|
        @income_value_total += income_value.value
      end

      #固定費計算
      @fixedcost_values = FixedcostValue.where(year_month: @year_month)
      @fixedcost_value_total = 0
      @fixedcost_values.each do |fixedcost_value|
        @fixedcost_value_total += fixedcost_value.value
      end

      #変動費計算
      @variablecost_values = VariablecostValue.where(year_month: @year_month)
      @variablecost_value_total = 0
      @variablecost_values.each do |variablecost_value|
        @variablecost_value_total += variablecost_value.value
      end

      #収支差
      @balance_differnce = @income_value_total - (@fixedcost_value_total + @variablecost_value_total)
  end

  def show_year
    year = params[:year]
    @year = year
    months = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    year_months = months.map do |month|
      year+"-"+month+"-01"
    end

    puts year_months

    #年度の収入配列を作成
    i=0
    total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    #グラフ用データ
    gon.data_incomes = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    year_months.each do |year_month|
      income_values = IncomeValue.where(year_month: year_month)
      if income_values.present?
        total[i] = cal_income_total(income_values)
        #グラフ用データ
        gon.data_incomes[i] = total[i]
      end
      i += 1
    end
    @income_value_totals = total

    #年度の固定費配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    gon.data_fixedcosts = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]	#グラフ用データ
		year_months.each do |year_month|
			fixedcost_values = FixedcostValue.where(year_month: year_month)
			if fixedcost_values.present?
				total[i] = cal_fixedcost_total(fixedcost_values)
        gon.data_fixedcosts[i] = total[i]	#グラフ用データ
			end
			i += 1
		end
		@fixedcost_value_totals = total

    #年度の変動費配列を作成
    i=0
    tatal = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    gon.data_variables = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    year_months.each do |year_month|
      variablecost_values = VariablecostValue.where(year_month: year_month)
      if variablecost_values.present?
        total[i] = cal_variablecost_total(variablecost_values)
        gon.data_variables[i] = total[i]
      end
      i += 1
    end
    @variablecost_value_totals = total

    #年度の収支結果を計算
    @balance_differences = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    gon.data_fesults = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    0.upto(11) do |i|
      if @income_value_totals[i].present?
        @balance_differences[i] = @income_value_totals[i] - (@fixedcost_value_totals[i] + @variablecost_value_totals[i])
        gon.data_fesults[i] = @balance_differences[i]
      end
    end
  end

  #収入トータル計算
  def cal_income_total(income_values)
    income_value_total = 0
    income_values.each do |income_value|
      income_value_total += income_value.value
    end
    income_value_total
  end

  #固定費トータル計算
  def cal_fixedcost_total(fixedcost_values)
    fixedcost_value_total = 0
    fixedcost_values.each do |fixedcost_value|
      fixedcost_value_total += fixedcost_value.value
    end
    fixedcost_value_total 
  end

  #変動費トータル計算
  def cal_variablecost_total(variablecost_values)
    variablecost_value_total = 0
    variablecost_values.each do |variablecost_value|
      variablecost_value_total += variablecost_value.value
    end
    variablecost_value_total
  end
end