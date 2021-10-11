# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSV.foreach(Rails.root.join('db/seeds/records.csv'), headers: true, col_sep: ';') do |row|
  Record.create!(
    league: row['league'],
    discipline: row['discipline'],
    athlete: row['athlete'],
    result: row['result'],
    location: row['location'],
    achieved_at: row['achieved_at']
  )
end
