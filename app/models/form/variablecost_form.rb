class Form::VariablecostForm < Form::Base
	attr_accessor :variablecost_values

	def initialize(attributes = {})
    super attributes

		variablecosts = Variablecost.order(created_at: :asc)
		self.variablecost_values = variablecosts.map { |variablecost| VariablecostValue.new(variablecost_id: variablecost.id) } unless variablecost_values.present?
  end

	def variablecost_values_attributes=(attributes)
    self.variablecost_values = attributes.map do |_, variablecost_value_attributes|
      Form::VariablecostValue.new(variablecost_value_attributes).tap { |v| puts v}
    end

  end

	def valid?
		valid_variablecost_values = self.variablecost_values.map(&:valid?).all?
		super && valid_variablecost_values
	end

	def save
		return false unless valid?
		VariablecostValue.transaction {
			self.variablecost_values.select.each { |variablecost_value|
				a1 = VariablecostValue.new(:variablecost_id => variablecost_value.variablecost_id,
					:year_month => variablecost_value.year_month,
					:value => variablecost_value.value,
					:description => variablecost_value.description)
				a1.save!
			 }
		}
		true
	end

	def target_variablecost_values
		self.variablecost_values.select { |v| '*' }
	end

end