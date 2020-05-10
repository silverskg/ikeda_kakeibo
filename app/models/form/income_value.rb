class Form::IncomeValue < IncomeValue
  REGISTRABLE_ATTRIBUTES = %i(income_id year_month value description)
  attr_accessor :income_id
  attr_accessor :year_month
  attr_accessor :value
  attr_accessor :description
  validates :value, presence: true
end