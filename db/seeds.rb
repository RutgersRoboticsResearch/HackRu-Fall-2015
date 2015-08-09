# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_INSECURE_PASSWORD = 'Bees1234'

User.create({
  first_name: "Greg",
  last_name: "Floresca",
  email: "gregfloresca@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Musashi",
  last_name: "Miyamoto",
  email: "miyamotomusashi@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Jonathan",
  last_name: "Risinger",
  email: "jonathanrisinger@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Tim",
  last_name: "Yong",
  email: "timyong@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Gloria",
  last_name: "Leung",
  email: "glorialeung@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

miyamoto = User.find_by_email('miyamotomusashi@gmail.com')
jonathan   = User.find_by_email('jonathanrisinger@gmail.com')
tim  = User.find_by_email('timyong@gmail.com')
greg  = User.find_by_email('gregfloresca@gmail.com')
gloria  = User.find_by_email('glorialeung@gmail.com')

seed_user = miyamoto

