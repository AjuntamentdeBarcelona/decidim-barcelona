![decidim-barcelona logo](https://raw.githubusercontent.com/AjuntamentdeBarcelona/decidim.barcelona/master/app/assets/images/decidim-logo.png)

# decidim-barcelona

---

Citizen Participation and Open Government Application.

[![[CI] Lint](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/lint.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/lint.yml)
[![[CI] Test](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test.yml)
[![[CI] Test Census SMS](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test_census_sms.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test_census_sms.yml)
[![[CI] Test Stats](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test_stats.yml/badge.svg)](https://github.com/AjuntamentdeBarcelona/decidim-barcelona/actions/workflows/test_stats.yml)
[![Code Climate](https://codeclimate.com/github/AjuntamentdeBarcelona/decidim-barcelona/badges/gpa.svg)](https://codeclimate.com/github/AjuntamentdeBarcelona/decidim-barcelona)

This is the opensource code repository for "decidim-barcelona", based on [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).

## Development environment setup

You can setup everything with Docker & Docker compose, run:

```bash
docker-compose build
docker-compose run --rm app bundle exec rake db:create db:schema:load db:seed
docker-compose up
```

## Available tasks

### Notifications removal

You can remove old notifications by running the `notifications:remove_old` task. You can specify the date until you want to preserve notifications and the date from which you will
remove them. By default it will delete all the notifications from 2017-01-01 older than 1 year if no params are provided.

For example, this one will remove all the notifications from 2023-11-12 to 2024-01-01:

```bash
bundle exec rake notifications:destroy_old["2024-01-01","2023-11-12"]
```

### Update 2024 Participatory budget proposals to fix missing translations

The proposals inside the 2024 participatory budget, sometimes, are created without the translations of the `copy_id` generated using the Term Customizer module.

This rake task will update the content of the proposals that have not translated the content and save them with the correct translation.

You can call this tasks for the two languages being used in the participatory process (Catalan and Spanish):

```bash
bundle exec rake proposals_budget_2024_translations:update_ca_translations
```

### Keep original authors in merged proposals

When merging proposals, the resulting proposal is automatically attributed to the current organization. If you want to preserve the original authorship, you can run this task. It
will update the merged proposal by assigning the original authors and removing the organization’s authority.

```bash
bundle exec rake rake decidim:change_merged_proposal_authors[proposal_id]
```

## License

Code published under AFFERO GPL v3 (see [LICENSE-AGPLv3.txt](LICENSE-AGPLv3.txt))

## Code of conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

## Create your own app

If you want to make your own instance of Decidim, do not fork us, just go to [Decidim](https://github.com/AjuntamentdeBarcelona/decidim).
