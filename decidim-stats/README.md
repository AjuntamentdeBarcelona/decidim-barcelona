# Decidim::Stats

## Production setup

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
bin/rake stats:generate
```

This command will send an email to the specified email addresses with the stats. You can use [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler#scheduling-jobs) to generate the file automatically every night.

## Stats CSV format

The CSV file has these columns:

```text
participatory_space_type,participatory_space_id,component_id,action,metric_type,metric_name,total
participatory_processes,2,4,comment,age_group,20-24,6
```

## Authorization data export page

This module adds a new admin page, “Export verification data” accessible under the Admin > Participants menu as “Export Data.”

On this page, admins can fill out a form to specify a Start Date, End Date, and Verification Method. Using these parameters, the form allows the export of census data gathered during the user verification process. Internally, it exports selected metadata fields from the Authorization model.


## Development guide

The module has different pieces:

- `Decidim::Stats::Runner`, which calculates the stats. Internally, it uses:
  - `Decidim::Stats::Performers`, which define how to group users by different metrics. The `Performers` select the users that have performed some action to later compute the stats from them. Each performer groups users by different criteria. Only users verified via the Census are considered. Current `performers` are:
    - `AgeGroup`, grouping by birth date
    - `District`, grouping by district
    - `Gender`, grouping by user sex/gender
  - `Decidim::Stats:Actions`, which define the different actions users perform and we want to track. All actions receive a `Decidim::Component` instance and a group of performers.
    - `Comment` counts how many performers have commented any resource of the given component
    - `Endorsement` counts how many performers have endorsed a resource of the given component
    - `Follow` counts how many performers have followed a resource of the given component
    - `ProposalCreation` counts how many performers have created a proposal in the given component
    - `ProposalVote` counts how many performers have voted a proposal of the given component
- `Decidim::Stats::CsvExporter`, which generates a temporary CSV file from the stats data
- `Decidim::Stats::StatsMailer`, which emails the CSV file to the emails specified in the environment variable.
- All the steps are run by the `Decidim::Stats::StatsJob`

Apart from these actions, the module calculates an `interactions` statistics that is the number of performers that have performed any of the previously listed actions in a given component.

## Developing your own action

Actions must receive a `Decidim::Component` instance and an `ActiveRecord:Relation` to the initializer, and must respond to a `#query` method that returns a list of user IDs that performed the given action.

In order for that action to be included you need to modify the `Decidim::Stats::Runner#actions` method and include the action class name.

## Developing your own performer class

Performers must define an `available_sections` class method that lists all the possible labels to group the users. These sections will be passed as a param to the initializer method. Performers must define a `#query` method that will return an `ActiveRecord::Relation` of `Decidim::User` records.

In order for that performer to be included you need to modify the `Decidim::Stats::Runner#performers` method and include the performer class name.

## Possible future improvements

- Add an `organization_id` parameter to the rake task so this module can be extracted from decidim-barcelona and used in multi-tenant installations.
- This module depends, and required the modification of, the `CensusAuthorizationHandler`. The data gathered with this module uses the Census authorization to group `performers`. This part should be abstracted into some interface in order to make the module installable in other Decidims.

## Contributing

See [Decidim
Barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona).

## License

See [Decidim
Barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona).
