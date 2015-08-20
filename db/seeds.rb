# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_INSECURE_PASSWORD = 'Bees1234'

User.create({
  first_name: "Jonathan",
  last_name: "Risinger",
  school_name: "Rutgers",
  diet: "No",
  git_account: "JMRisinger",
  profile_name: "Jon",
  email: "jonathanrisinger@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

jonathan = User.find_by_email('jonathanrisinger@gmail.com')

seed_user = jonathan

seed_user.statuses.create(content: "Hello, world!")
jonathan.statuses.create(content: "Hi, I'm Jon")
