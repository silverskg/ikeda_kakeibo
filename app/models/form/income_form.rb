class Form::IncomeForm < Form::Base
  attr_accessor :income_values

  def initialize(attributes = {})
    super attributes
    incomes = Income.order(created_at: :asc)
    self.income_values = incomes.map { |income| IncomeValue.new(income_id: income.id) } unless income_values.present?
  end

  def income_values_attributes=(attributes)
    self.income_values = attributes.map do |_, income_value_attributes|
      Form::IncomeValue.new(income_value_attributes).tap { |v| puts v}
    end
  end

  def valid?
    valid_income_values = self.income_values.map(&:valid?).all?
    super && valid_income_values
  end

  def save
    return false unless valid?
    IncomeValue.transaction {
      self.income_values.select.each { |income_value|
        a1 = IncomeValue.new(:income_id => income_value.income_id,
          :year_month => income_value.year_month,
          :value => income_value.value,
          :description => income_value.description)
        a1.save!
      }
    }
    true
  end

  def target_income_values
    self.income_values.select { |v| '*' }
  end

end