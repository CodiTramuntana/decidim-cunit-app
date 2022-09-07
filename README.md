# decidim_cunit

Free Open-Source participatory democracy, citizen participation and open government for cities and organizations

This is the open-source repository for decidim_cunit, based on [Decidim](https://github.com/decidim/decidim).

## Setting up the application

You will need to do some steps before having the app working properly once you've deployed it:

1. Open a Rails console in the server: `bundle exec rails console`
2. Create a System Admin user:
```ruby
user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
user.save!
```
3. Visit `<your app url>/system` and login with your system admin credentials
4. Create a new organization. Check the locales you want to use for that organization, and select a default locale.
5. Set the correct default host for the organization, otherwise the app will not work properly. Note that you need to include any subdomain you might be using.
6. Fill the rest of the form and submit it.

By the moment, there's no Here Maps configured yet.

You're good to go!

## Decorators and overrides
Decorators and overrides must be checked in Decidim upgrades.

### Add personal data fields (name, surname and phone) in Proposals.

- **app/decorators/commands/proposals/**

- **app/decorators/forms/proposals/**

- **app/decorators/lib/proposals/**

- **app/overrides/proposals/**


## Testing

Configure the name of the test DB in you `config/application.yml` file and run:

```
RAILS_ENV=test bundle exec rails db:create
RAILS_ENV=test bundle exec rails db:migrate
```

Require missing factories in `spec/factories.rb`

Add `require "rails_helper"` to your specs and execute them from the **root directory**, i.e.:

`bundle exec rspec spec`
