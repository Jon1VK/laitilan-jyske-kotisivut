require "administrate/field/base"

class DynamicSelectField < Administrate::Field::Base
  def self.searchable?
    true
  end

  def selectable_options
    collection
  end

  def include_blank_option
    options.fetch(:include_blank, false)
  end

  def custom_data
    options.fetch(:custom_data, {})
  end

  private

  def collection
    values = options.fetch(:collection, [])
    if values.respond_to? :call
      return values.arity.positive? ? values.call(self) : values.call
    end

    @collection ||= values
  end
end
