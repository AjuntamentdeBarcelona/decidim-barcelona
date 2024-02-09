![decidim-barcelona logo](https://raw.githubusercontent.com/AjuntamentdeBarcelona/decidim.barcelona/master/app/assets/images/decidim-logo.png)

# decidim-barcelona

---

Citizen Participation and Open Government Application.

[![[CI] Lint](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/lint.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/lint.yml)
[![[CI] Test](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test.yml)
[![Code Climate](https://codeclimate.com/github/AjuntamentdeBarcelona/decidim-barcelona/badges/gpa.svg)](https://codeclimate.com/github/AjuntamentdeBarcelona/decidim-barcelona)

This is the opensource code repository for "decidim-barcelona", based on [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).

## Development environment setup

You can setup everything with Docker & Docker compose, run:

```bash
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
