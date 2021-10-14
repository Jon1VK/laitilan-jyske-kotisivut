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
#  reviewed    :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_records_on_discipline  (discipline)
#  index_records_on_league      (league)
#
class Record < ApplicationRecord
  LEAGUES_BY_GENDER = {
    'Aikuiset' => %w[Miehet Naiset],
    'Pojat' => %w[Pojat\ 9 Pojat\ 10 Pojat\ 11 Pojat\ 12 Pojat\ 13 Pojat\ 14 Pojat\ 15],
    'Tytöt' => %w[Tytöt\ 9 Tytöt\ 10 Tytöt\ 11 Tytöt\ 12 Tytöt\ 13 Tytöt\ 14 Tytöt\ 15],
  }

  LEAGUES = LEAGUES_BY_GENDER.values.reduce(&:+)

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

  DISCIPLINES = DISCIPLINES_BY_LEAGUE.values.reduce(&:|)

  validates :league, presence: :true, inclusion: { in: LEAGUES }
  validates :discipline, presence: :true
  validate :discipline_must_be_in_league, if: -> { league.present? }
  validates :athlete, presence: true
  validates :result, presence: true
  validates :location, presence: true
  validates :achieved_at, presence: true

  def discipline_must_be_in_league
    unless DISCIPLINES_BY_LEAGUE[league].include?(discipline)
      errors.add(:discipline, "ei ole valitsemassasi sarjassa")
    end
  end

  def self.club_records_by_league(league)
    group_by_discipline(Record.find_by_sql([<<-SQL, league: league]))
      SELECT *
      FROM records AS R1
      JOIN (
        SELECT
          discipline,
          CASE
            WHEN discipline SIMILAR TO '[0-9]%|Puoli%|Maraton%' THEN MIN(LPAD(result, 10, '0'))
            ELSE MAX(LPAD(result, 10, '0'))
          END AS top_result
        FROM records
        WHERE league=:league AND reviewed
        GROUP BY discipline
      ) AS R2 ON R1.discipline=R2.discipline
      WHERE league=:league AND reviewed AND LPAD(R1.result, 10, '0')=R2.top_result
      ORDER BY achieved_at
    SQL
  end

  def self.top_ten_records_by_league_and_discipline(league, discipline)
    Record.find_by_sql([<<-SQL, league: league, discipline: discipline])
      SELECT *
      FROM records as R1
      JOIN (
        SELECT
          athlete,
          CASE
            WHEN discipline SIMILAR TO '[0-9]%|Puoli%|Maraton%' THEN MIN(LPAD(result, 10, '0'))
            ELSE MAX(LPAD(result, 10, '0'))
          END AS top_result
        FROM records
        WHERE league=:league AND discipline=:discipline AND reviewed
        GROUP BY athlete, discipline
      ) AS R2 ON R1.athlete=R2.athlete
      WHERE league=:league AND discipline=:discipline AND reviewed AND LPAD(R1.result, 10, '0')=R2.top_result
      ORDER BY
        CASE WHEN discipline SIMILAR TO '[0-9]%|Puoli%|Maraton' THEN LPAD(result, 10, '0') END ASC,
        LPAD(result, 10, '0') DESC,
        achieved_at ASC
      LIMIT 10
    SQL
  end

  def self.group_by_discipline(records)
    records.reduce(Hash.new { |h, k| h[k] = [] }) do |grouped_records, record|
      grouped_records[record.discipline] << record
      grouped_records
    end
  end
end
