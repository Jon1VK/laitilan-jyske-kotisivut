# == Schema Information
#
# Table name: records
#
#  id          :bigint           not null, primary key
#  achieved_at :date             not null
#  athlete     :string           not null
#  discipline  :string           not null
#  league      :string           not null
#  location    :string           not null
#  result      :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_records_on_discipline  (discipline)
#  index_records_on_league      (league)
#
class Record < ApplicationRecord
  LEAGUES = %w[
    Pojat\ 9
    Pojat\ 10
    Pojat\ 11
    Pojat\ 12
    Pojat\ 13
    Pojat\ 14
    Pojat\ 15
    Tytöt\ 9
    Tytöt\ 10
    Tytöt\ 11
    Tytöt\ 12
    Tytöt\ 13
    Tytöt\ 14
    Tytöt\ 15
    Miehet
    Naiset
  ]

  DISCIPLINES_BY_LEAGUE = {
    'Pojat 9' => %w[40m 1000m Korkeus Pituus Kuula Kiekko Moukari Keihäs Kolmiottelu Neliottelu 600m\ kävely],
    'Pojat 10' => %w[60m 1000m 60m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Kolmiottelu Neliottelu 1000m\ kävely],
    'Pojat 11' => %w[60m 1000m 60m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Kolmiottelu Neliottelu 1000m\ kävely],
    'Pojat 12' => %w[60m 200m 1000m 60m\ aitajuoksu 200m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Neliottelu Viisiottelu 2000m\ kävely],
    'Pojat 13' => %w[60m 200m 1000m 60m\ aitajuoksu 200m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Neliottelu Viisiottelu 2000m\ kävely],
    'Pojat 14' => %w[100m 300m 800m 2000m 1500m\ estejuoksu 100m\ aitajuoksu 300m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Viisiottelu 3000m\ kävely],
    'Pojat 15' => %w[100m 300m 800m 2000m 1500m\ estejuoksu 100m\ aitajuoksu 300m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Viisiottelu 3000m\ kävely],
    'Tytöt 9' => %w[40m 1000m Korkeus Pituus Kuula Kiekko Moukari Keihäs Kolmiottelu Neliottelu 600m\ kävely],
    'Tytöt 10' => %w[60m 1000m 60m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Kolmiottelu Neliottelu 1000m\ kävely],
    'Tytöt 11' => %w[60m 1000m 60m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Kolmiottelu Neliottelu 1000m\ kävely],
    'Tytöt 12' => %w[60m 200m 1000m 60m\ aitajuoksu 200m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Neliottelu Viisiottelu 2000m\ kävely],
    'Tytöt 13' => %w[60m 200m 1000m 60m\ aitajuoksu 200m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Neliottelu Viisiottelu 2000m\ kävely],
    'Tytöt 14' => %w[100m 300m 800m 2000m 1500m\ estejuoksu 80m\ aitajuoksu 300m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Viisiottelu 3000m\ kävely],
    'Tytöt 15' => %w[100m 300m 800m 2000m 1500m\ estejuoksu 80m\ aitajuoksu 300m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Viisiottelu 3000m\ kävely],
    'Miehet' => %w[100m 200m 400m 800m 1500m 3000m 5000m 10000m Puolimaraton Maraton 3000m\ estejuoksu 110m\ aitajuoksu 400m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Kymmenottelu 20km\ kävely 50km\ kävely],
    'Naiset' => %w[100m 200m 400m 800m 1500m 3000m 5000m 10000m Puolimaraton Maraton 3000m\ estejuoksu 100m\ aitajuoksu 400m\ aitajuoksu Korkeus Seiväs Pituus Kolmiloikka Kuula Kiekko Moukari Keihäs Seitsenottelu 10km\ kävely 20km\ kävely],
  }

  validates :league, presence: :true, inclusion: { in: LEAGUES }
  validates :discipline, presence: :true
  validate :discipline_must_be_in_league, if: -> { league.present? }
  validates :athlete, presence: true, uniqueness: { scope: [:league, :discipline] }
  validates :result, presence: true
  validates :location, presence: true
  validates :achieved_at, presence: true

  def discipline_must_be_in_league
    unless DISCIPLINES_BY_LEAGUE[league].include?(discipline)
      errors.add(:discipline, "ei ole valitsemassasi sarjassa")
    end
  end
end
