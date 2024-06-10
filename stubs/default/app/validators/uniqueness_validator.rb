class UniquenessValidator < ActiveRecord::Validations::UniquenessValidator
  def initialize(klass)
    super
    @klass = options[:model] if options[:model]
  end

  def validate_each(record, attribute, value)
    if !options[:model] && !record.class.ancestors.include?(ActiveRecord::Base)
      raise ArgumentError, "Unknown validator: 'UniquenessValidator'"
    end

    super unless options[:model]

    record_org = record
    attribute_org = attribute

    attribute = options[:attribute].to_sym if options[:attribute]
    record = options[:model].new(attribute => value)

    super

    record_org.errors.add(attribute_org, :taken) if record.errors.any?
  end
end
