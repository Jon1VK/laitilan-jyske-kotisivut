require "administrate/base_dashboard"

class RecordDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    league: DynamicSelectField.with_options(
      collection: Record::LEAGUES,
      custom_data: { action: 'change->record#change', record_target: 'leagueSelect' },
      prompt: 'Valitse sarja'
    ),
    discipline: DynamicSelectField.with_options(
      collection: Record::DISCIPLINES,
      custom_data: { record_target: 'disciplineSelect' },
      prompt: 'Valitse laji'
    ),
    athlete: Field::String,
    result: Field::String,
    location: Field::String,
    achieved_at: Field::Date,
    reviewed: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    league
    discipline
    athlete
    result
    location
    achieved_at
    reviewed
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    league
    discipline
    athlete
    result
    location
    achieved_at
    reviewed
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    league
    discipline
    athlete
    result
    location
    achieved_at
    reviewed
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how records are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(record)
    "#{record.league} - #{record.discipline}: #{record.athlete}"
  end
end
