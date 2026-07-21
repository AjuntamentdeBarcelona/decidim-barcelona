---
name: decidim-overrides
description: Conventions for overriding or extending decidim gem code in this app (controllers, commands, forms, models, cells, helpers, views, routes). Use whenever a change touches behavior that lives in a decidim gem, when copying a gem view into app/views, when wiring an *Override concern, or when spec/lib/overrides_spec.rb fails after a decidim upgrade.
---

# Overriding decidim gem code in decidim-barcelona

This app customizes the decidim gems (installed from the `AjuntamentdeBarcelona/decidim` fork) without patching the gems themselves. Every override follows the same four conventions. **All of them end with registering the original gem file in `spec/lib/overrides_spec.rb` — never skip that step.**

Find the installed gem source with `bundle show <gem>` (e.g. `bundle show decidim-admin`).

## 1. Ruby classes (controllers, commands, forms, models, cells, helpers, presenters, permissions, serializers)

Create a concern named after the class with an `Override` suffix, mirroring the gem path under `concerns`:

```
app/controllers/concerns/decidim/admin/officializations_controller_override.rb
app/commands/concerns/decidim/initiatives/admin/update_initiative_override.rb
```

```ruby
# frozen_string_literal: true

module Decidim
  module Admin
    module OfficializationsControllerOverride
      extend ActiveSupport::Concern

      included do
        def resend_invitation
          # ...
        end
      end
    end
  end
end
```

Wire it in `config/initializers/decidim_overrides.rb`, inside the existing `Rails.application.config.to_prepare` block:

- `.include(...)` when **adding** new methods.
- `.prepend(...)` when **replacing** existing methods (so `super` still works).

## 2. Views

Copy the full gem view to the same path under `app/views/` and apply the change there (e.g. `app/views/decidim/admin/officializations/index.html.erb`). Plain copies, no source-marker comments — repo style.

Note: decidim_awesome applies Deface overrides by virtual path, so they still compose on top of app-level copies. If the copied view looks different in the browser than in the file, check for Deface overrides before assuming a bug.

## 3. Engine routes

Draw extra routes on the engine directly in `config/routes.rb` (see the existing `Decidim::System::Engine.routes.draw` block):

```ruby
Decidim::Admin::Engine.routes.draw do
  resources :officializations, only: [], param: :user_id do
    member do
      post :resend_invitation
    end
  end
end
```

## 4. MANDATORY: register checksums in spec/lib/overrides_spec.rb

Every gem file that is overridden **or extended** must be listed in `spec/lib/overrides_spec.rb` under its `package:` block, mapping the gem-relative path to the MD5 of the **original gem file** (not the app copy):

```bash
md5 -q "$(bundle show decidim-admin)/app/views/decidim/admin/officializations/index.html.erb"
```

```ruby
"/app/views/decidim/admin/officializations/index.html.erb" => "e68f2a9b4887212f21756de25394ff53", # resend invitation action added to the table
```

Rules:

- This includes classes that are only *extended* via an `include`d concern (e.g. `meetings_controller.rb` is tracked even though only a concern touches it) — the override depends on the gem file's internals, so upstream changes there need review too.
- Add a short trailing comment saying why/where it is overridden; link the upstream PR if the override is a backport/revert that can be deleted later.
- Verify with `bundle exec rspec spec/lib/overrides_spec.rb`.

**Why:** on a decidim upgrade this spec fails for every overridden file that changed upstream, telling the team exactly which overrides need re-review.

## When overrides_spec.rb fails after a decidim upgrade

1. Diff the new gem file against the previous release to see what changed upstream.
2. Port relevant upstream changes into the app override (view copy or concern).
3. If the override is no longer needed (upstream fixed it), delete the override, its wiring in `decidim_overrides.rb`, and its checksum entry.
4. Update the checksum to the new gem file's MD5 and re-run the spec.

## Checklist for any new override

- [ ] Concern + wiring in `config/initializers/decidim_overrides.rb` (or view copy / engine route).
- [ ] Checksum entry with comment in `spec/lib/overrides_spec.rb`.
- [ ] `bundle exec rspec spec/lib/overrides_spec.rb` green.
- [ ] RuboCop green on the new files.
- [ ] Spec covering the new behavior (system spec for UI changes).
