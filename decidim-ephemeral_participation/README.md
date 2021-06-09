# Decidim::EphemeralParticipation

This module adds a specific integration with local Barcelona services so citizens can participate without registration.

> NOTE: this module might be provisional if the main changes introduces by it are ported to `decidim-core`
> (which is the intention of the team behind it)

## Install

Available_authorizations can now hold some configurable data, this migrations takes car of updating the organization field:

```
rails decidim_ephemeral_participation:install:migrations
```

In order to allow an Authorization handler to be used for ephemeral participation, it needs to be configured in the initializer:

```ruby
# config/initializers/decidim.rb

Decidim::Verifications.register_workflow(:census) do |workflow|
  workflow.form = "myAuthorizationHandlerClass"
  workflow.renewable = true
  workflow.time_between_renewals = 1.day
  workflow.metadata_cell = "decidim/verifications/authorization_metadata"
  # set the next varialble to true to allows the system admin use this as a method for direct participation
  workflow.ephemerable = true
end
```

**IMPORANT**
The following assumptions are made:
- The verification worflow is responsible for making users accept the TOS.
- The verification worflow is redirecting to `decidim_verification.authorizations_path` after granting the authorization.

## Contributing

See [Decidim
Barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona).

## License

See [Decidim
Barcelona](https://github.com/AjuntamentdeBarcelona/decidim-barcelona).
