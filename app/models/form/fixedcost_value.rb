class Form::FixedcostValue < FixedcostValue
  REGISTRABLE_ATTRIBUTES = %i(fixedcost_id year_month value description)
  attr_accessor :fixedcost_id
  attr_accessor :year_month
  attr_accessor :value
  attr_accessor :description
  validates :value, presence: true
end