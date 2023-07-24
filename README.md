![decidim-barcelona logo](https://raw.githubusercontent.com/AjuntamentdeBarcelona/decidim.barcelona/master/app/assets/images/decidim-logo.png)

# decidim-barcelona

---

Citizen Participation and Open Government Application. 

[![Build Status](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/decidim_ci.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/decidim_ci.yml)
[![Code Climate](https://codeclimate.com/github/AjuntamentdeBarcelona/decidim-barcelona/badges/gpa.svg)](https://codeclimate.com/github/AjuntamentdeBarcelona/decidim-barcelona)

This is the opensource code repository for "decidim-barcelona", based on [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).

## Upgrade notes

- `app/views/layouts/decidim/widget.html.erb` modify the embed to remove organization's logo.
- `app/stylesheets/decidim/email.css`, customizes the email template style of Decidim. Be careful in later updates to prevent changes in style.

## Development environment setup

You can setup everything with Docker & Docker compose, run:

```
docker-compose build
docker-compose run --rm app bundle exec rake db:create db:schema:load db:seed
docker-compose up
```

## License

Code published under AFFERO GPL v3 (see [LICENSE-AGPLv3.txt](LICENSE-AGPLv3.txt))

## Code of conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

## Create your own app

If you want to make your own instance of Decidim, do not fork us, just go to [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).
