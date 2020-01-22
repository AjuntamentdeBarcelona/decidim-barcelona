# Decidim::Stats

This module adds demographic statistics about the participants.

In order to run it, please check you have these environment variables set:

```text
STATS_MINIMUM_COUNT=5
STATS_EMAILS=foo@example.org,bar@example.org
```

`STATS_MINIMUM_COUNT` sets the lower limit of data to be exported. Any stats with a total below that number will be ignored. The default value is `5`.

`STATS_EMAILS` is a list of the emails the stats file will be sent to. If you eed to send it to more than one email, please separate them by commas: `foo@bar.com,yaz@zez.com`

Assuming you have access to the Heroku application, use this command to set the environment variables:

```text
heroku config:set STATS_MINIMUM_COUNT=5 STATS_EMAILS=foo@example.org,bar@example.org
```

The command to generate the stats file is this:

```text
rake stats:generate
```

This command will send an email to thre specified email addresses with the stats. You can use [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler#scheduling-jobs) to generate the file automatically every night.

## Contributing
See [Decidim
Barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona).

## License
See [Decidim
Barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona).
