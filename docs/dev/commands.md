# Commands

## Rails commands

- Execute rails console

`rails c`

- Execute rails server

`rails s`

## Database commands

- Create database

`rails db:create`

- Run migrations

`rails db:migrate`

- Run seeds (faker data for database)

`rails db:seed`

- Drop database

`rails db:drop`

- Reset database = (drop + migrate + seed)

`rails db:reset`

- With the database create, run next commands (migrate + seed)

`rails db:setup`

- Generate migration

`rails g migration name_of_the_migration`

## Rswag generate documentation

- Generate rswag documentation

`rake rswag:specs:swaggerize`

# Rspec commands

- Run rspec without swagger documentation

`bundle exec rspec --exclude-pattern "spec/requests/**/*_spec.rb"`
