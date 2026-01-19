# frozen_string_literal: true

Decidim.configure do |config|
  # The name of the application
  config.application_name = ENV.fetch("DECIDIM_APPLICATION_NAME", "Decidim Barcelona")

  # The email that will be used as sender in all emails from Decidim
  config.mailer_sender = ENV.fetch("DECIDIM_MAILER_SENDER", "noreply@example.org")

  # Sets the list of available locales for the whole application.
  #
  # When an organization is created through the System area, system admins will
  # be able to choose the available languages for that organization. That list
  # of languages will be equal or a subset of the list in this file.
  config.available_locales = ENV.fetch("DECIDIM_AVAILABLE_LOCALES", "ca,es,oc").split(",").map(&:strip).map(&:to_sym)
  # Or block set it up manually and prevent ENV manipulation:
  # config.available_locales = %w(en ca es)

  # Sets the default locale for new organizations. When creating a new
  # organization from the System area, system admins will be able to overwrite
  # this value for that specific organization.
  config.default_locale = ENV.fetch("DECIDIM_DEFAULT_LOCALE", "ca").to_sym

  # Restrict access to the system part with an authorized ip list.
  # You can use a single ip like ("1.2.3.4"), or an ip subnet like ("1.2.3.4/24")
  # You may specify multiple ip in an array ["1.2.3.4", "1.2.3.4/24"]
  config.system_accesslist_ips = ENV["DECIDIM_SYSTEM_ACCESSLIST_IPS"].split(",").map(&:strip) if ENV["DECIDIM_SYSTEM_ACCESSLIST_IPS"].present?

  # Defines a list of custom content processors. They are used to parse and
  # render specific tags inside some user-provided content. Check the docs for
  # more info.
  # config.content_processors = []

  # Whether SSL should be enabled or not.
  # if this var is not defined, it is decided automatically per-rails-environment
  config.force_ssl = ENV["DECIDIM_FORCE_SSL"].present? unless ENV["DECIDIM_FORCE_SSL"] == "auto"
  # or set it up manually and prevent any ENV manipulation:
  # config.force_ssl = true

  # Enable the service worker. By default is disabled in development and enabled in the rest of environments
  config.service_worker_enabled = ENV["DECIDIM_SERVICE_WORKER_ENABLED"].present?

  # Map and Geocoder configuration
  #
  # == HERE Maps ==
  # config.maps = {
  #   provider: :here,
  #   api_key: ENV["MAPS_API_KEY"],
  #   static: { url: "https://image.maps.ls.hereapi.com/mia/1.6/mapview" }
  # }
  #
  # == OpenStreetMap (OSM) services ==
  # To use the OSM map service providers, you will need a service provider for
  # the following map servers or host all of them yourself:
  # - A tile server for the dynamic maps
  #   (https://wiki.openstreetmap.org/wiki/Tile_servers)
  # - A Nominatim geocoding server for the geocoding functionality
  #   (https://wiki.openstreetmap.org/wiki/Nominatim)
  # - A static map server for static map images
  #   (https://github.com/jperelli/osm-static-maps)
  #
  # When used, please read carefully the terms of service for your service
  # provider.
  #
  # config.maps = {
  #   provider: :osm,
  #   api_key: ENV["MAPS_API_KEY"],
  #   dynamic: {
  #     tile_layer: {
  #       url: "https://tiles.example.org/{z}/{x}/{y}.png?key={apiKey}&{foo}",
  #       api_key: true,
  #       foo: "bar=baz",
  #       attribution: %(
  #         <a href="https://www.openstreetmap.org/copyright" target="_blank">&copy; OpenStreetMap</a> contributors
  #       ).strip
  #       # Translatable attribution:
  #       # attribution: -> { I18n.t("tile_layer_attribution") }
  #     }
  #   },
  #   static: { url: "https://staticmap.example.org/" },
  #   geocoding: { host: "nominatim.example.org", use_https: true }
  # }
  #
  # == Combination (OpenStreetMap default + HERE Maps dynamic map tiles) ==
  # config.maps = {
  #   provider: :osm,
  #   api_key: ENV["MAPS_API_KEY"],
  #   dynamic: {
  #     provider: :here,
  #     api_key: ENV["MAPS_HERE_API_KEY"]
  #   },
  #   static: { url: "https://staticmap.example.org/" },
  #   geocoding: { host: "nominatim.example.org", use_https: true }
  # }

  # Geocoder configurations if you want to customize the default geocoding
  # settings. The maps configuration will manage which geocoding service to use,
  # so that does not need any additional configuration here. Use this only for
  # the global geocoder preferences.
  # config.geocoder = {
  #   # geocoding service request timeout, in seconds (default 3):
  #   timeout: 5,
  #   # set default units to kilometers:
  #   units: :km,
  #   # caching (see https://github.com/alexreisner/geocoder#caching for details):
  #   cache: Redis.new,
  #   cache_prefix: "..."
  # }
  if ENV["MAPS_STATIC_PROVIDER"].present?
    static_provider = ENV["MAPS_STATIC_PROVIDER"]
    dynamic_provider = ENV.fetch("MAPS_DYNAMIC_PROVIDER", nil)
    dynamic_url = ENV.fetch("MAPS_DYNAMIC_URL", nil)
    static_url = ENV.fetch("MAPS_STATIC_URL", nil)
    static_url = "https://image.maps.hereapi.com/mia/v3/base/mc/overlay" if static_provider == "here" && static_url.blank?
    config.maps = {
      provider: static_provider,
      api_key: ENV.fetch("MAPS_STATIC_API_KEY", nil),
      static: { url: static_url },
      dynamic: {
        provider: dynamic_provider,
        api_key: ENV.fetch("MAPS_DYNAMIC_API_KEY", nil)
      }
    }
    config.maps[:geocoding] = { host: ENV["MAPS_GEOCODING_HOST"], use_https: true } if ENV["MAPS_GEOCODING_HOST"].present?
    config.maps[:dynamic][:tile_layer] = {}
    config.maps[:dynamic][:tile_layer][:url] = dynamic_url if dynamic_url
    config.maps[:dynamic][:tile_layer][:attribution] = ENV["MAPS_ATTRIBUTION"] if ENV["MAPS_ATTRIBUTION"].present?
    if ENV["MAPS_EXTRA_VARS"].present?
      vars = URI.decode_www_form(ENV["MAPS_EXTRA_VARS"])
      vars.each do |key, value|
        # perform a naive type conversion
        config.maps[:dynamic][:tile_layer][key] = case value
                                                  when /^true$|^false$/i
                                                    value.downcase == "true"
                                                  when /\A[-+]?\d+\z/
                                                    value.to_i
                                                  else
                                                    value
                                                  end
      end
    end
  end

  # Custom resource reference generator method. Check the docs for more info.
  # config.reference_generator = lambda do |resource, component|
  #   # Implement your custom method to generate resources references
  #   "1234-#{resource.id}"
  # end

  # Currency unit
  config.currency_unit = ENV["DECIDIM_CURRENCY_UNIT"] if ENV["DECIDIM_CURRENCY_UNIT"].present?

  # Workaround to enable SVG assets cors
  config.cors_enabled = ENV["DECIDIM_CORS_ENABLED"].present?

  # Defines the quality of image uploads after processing. Image uploads are
  # processed by Decidim, this value helps reduce the size of the files.
  config.image_uploader_quality = ENV.fetch("DECIDIM_IMAGE_UPLOADER_QUALITY", "80").to_i

  config.maximum_attachment_size = ENV.fetch("DECIDIM_MAXIMUM_ATTACHMENT_SIZE", "10").to_i.megabytes
  config.maximum_avatar_size = ENV.fetch("DECIDIM_MAXIMUM_AVATAR_SIZE", "5").to_i.megabytes

  # The number of reports which a resource can receive before hiding it
  config.max_reports_before_hiding = ENV.fetch("DECIDIM_MAX_REPORTS_BEFORE_HIDING", "3").to_i

  # Custom HTML Header snippets
  #
  # The most common use is to integrate third-party services that require some
  # extra JavaScript or CSS. Also, you can use it to add extra meta tags to the
  # HTML. Note that this will only be rendered in public pages, not in the admin
  # section.
  #
  # Before enabling this you should ensure that any tracking that might be done
  # is in accordance with the rules and regulations that apply to your
  # environment and usage scenarios. This component also comes with the risk
  # that an organization's administrator injects malicious scripts to spy on or
  # take over user accounts.
  #
  config.enable_html_header_snippets = ENV["DECIDIM_ENABLE_HTML_HEADER_SNIPPETS"].present?

  # Allow organizations admins to track newsletter links.
  config.track_newsletter_links = ENV["DECIDIM_TRACK_NEWSLETTER_LINKS"].present? unless ENV["DECIDIM_TRACK_NEWSLETTER_LINKS"] == "auto"

  # Amount of time that the download your data files will be available in the server.
  config.download_your_data_expiry_time = ENV.fetch("DECIDIM_DOWNLOAD_YOUR_DATA_EXPIRY_TIME", "7").to_i.days

  # Max requests in a time period to prevent DoS attacks. Only applied on production.
  config.throttling_max_requests = ENV.fetch("DECIDIM_THROTTLING_MAX_REQUESTS", "100").to_i

  # Time window in which the throttling is applied.
  config.throttling_period = ENV.fetch("DECIDIM_THROTTLING_PERIOD", "1").to_i.minutes

  # Time window were users can access the website even if their email is not confirmed.
  config.unconfirmed_access_for = ENV.fetch("DECIDIM_UNCONFIRMED_ACCESS_FOR", "0").to_i.days

  # A base path for the uploads. If set, make sure it ends in a slash.
  # Uploads will be set to `<base_path>/uploads/`. This can be useful if you
  # want to use the same uploads place for both staging and production
  # environments, but in different folders.
  #
  # If not set, it will be ignored.
  config.base_uploads_path = ENV["DECIDIM_BASE_UPLOADS_PATH"] if ENV["DECIDIM_BASE_UPLOADS_PATH"].present?

  # SMS gateway configuration
  #
  # If you want to verify your users by sending a verification code via
  # SMS you need to provide a SMS gateway service class.
  #
  # An example class would be something like:
  #
  # class MySMSGatewayService
  #   attr_reader :mobile_phone_number, :code
  #
  #   def initialize(mobile_phone_number, code)
  #     @mobile_phone_number = mobile_phone_number
  #     @code = code
  #   end
  #
  #   def deliver_code
  #     # Actual code to deliver the code
  #     true
  #   end
  # end
  #
  # config.sms_gateway_service = "MySMSGatewayService"

  # Timestamp service configuration
  #
  # Provide a class to generate a timestamp for a document. The instances of
  # this class are initialized with a hash containing the :document key with
  # the document to be timestamped as value. The istances respond to a
  # timestamp public method with the timestamp
  #
  # An example class would be something like:
  #
  # class MyTimestampService
  #   attr_accessor :document
  #
  #   def initialize(args = {})
  #     @document = args.fetch(:document)
  #   end
  #
  #   def timestamp
  #     # Code to generate timestamp
  #     "My timestamp"
  #   end
  # end
  #
  #
  config.timestamp_service = "TimestampService"

  # PDF signature service configuration
  #
  # Provide a class to process a pdf and return the document including a
  # digital signature. The instances of this class are initialized with a hash
  # containing the :pdf key with the pdf file content as value. The instances
  # respond to a signed_pdf method containing the pdf with the signature
  #
  # An example class would be something like:
  #
  # class MyPDFSignatureService
  #   attr_accessor :pdf
  #
  #   def initialize(args = {})
  #     @pdf = args.fetch(:pdf)
  #   end
  #
  #   def signed_pdf
  #     # Code to return the pdf signed
  #   end
  # end
  #
  config.pdf_signature_service = "PdfSignatureBarcelona"

  # Etherpad configuration
  #
  # Only needed if you want to have Etherpad integration with Decidim. See
  # Decidim docs at https://docs.decidim.org/en/services/etherpad/ in order to set it up.
  #
  if ENV["ETHERPAD_SERVER"].present?
    config.etherpad = {
      server: ENV["ETHERPAD_SERVER"],
      api_key: ENV.fetch("ETHERPAD_API_KEY", nil),
      api_version: ENV.fetch("ETHERPAD_API_VERSION", "1.2.1")
    }
  end

  # Sets Decidim::Exporters::CSV's default column separator
  config.default_csv_col_sep = ENV["DECIDIM_DEFAULT_CSV_COL_SEP"] if ENV["DECIDIM_DEFAULT_CSV_COL_SEP"].present?

  # The list of roles a user can have, not considering the space-specific roles.
  # config.user_roles = %w(admin user_manager)

  # The list of visibility options for amendments. An Array of Strings that
  # serve both as locale keys and values to construct the input collection in
  # Decidim::Amendment::VisibilityStepSetting::options.
  #
  # This collection is used in Decidim::Admin::SettingsHelper to generate a
  # radio buttons collection input field form for a Decidim::Component
  # step setting :amendments_visibility.
  # config.amendments_visibility_options = %w(all participants)

  # Machine Translation Configuration
  #
  # See Decidim docs at https://docs.decidim.org/en/develop/machine_translations/
  # for more information about how it works and how to set it up.
  #
  # Enable machine translations
  config.enable_machine_translations = false
  #
  # If you want to enable machine translation you can create your own service
  # to interact with third party service to translate the user content.
  #
  # If you still want to use "Decidim::Dev::DummyTranslator" as translator placeholder,
  # add the follwing line at the beginning of this file:
  # require "decidim/dev/dummy_translator"
  #
  # An example class would be something like:
  #
  # class MyTranslationService
  #   attr_reader :text, :original_locale, :target_locale
  #
  #   def initialize(text, original_locale, target_locale)
  #     @text = text
  #     @original_locale = original_locale
  #     @target_locale = target_locale
  #   end
  #
  #   def translate
  #     # Actual code to translate the text
  #   end
  # end
  #
  # config.machine_translation_service = "MyTranslationService"

  # Defines the name of the cookie used to check if the user allows Decidim to
  # set cookies.
  config.consent_cookie_name = ENV["DECIDIM_CONSENT_COOKIE_NAME"] if ENV["DECIDIM_CONSENT_COOKIE_NAME"].present?

  # Defines data consent categories and the data stored in each category.
  # config.consent_categories = [
  #   {
  #     slug: "essential",
  #     mandatory: true,
  #     items: [
  #       {
  #         type: "cookie",
  #         name: "_session_id"
  #       },
  #       {
  #         type: "cookie",
  #         name: Decidim.consent_cookie_name
  #       }
  #     ]
  #   },
  #   {
  #     slug: "preferences",
  #     mandatory: false
  #   },
  #   {
  #     slug: "analytics",
  #     mandatory: false
  #   },
  #   {
  #     slug: "marketing",
  #     mandatory: false
  #   }
  # ]

  # Admin admin password configurations
  admin_password_strong = ENV.fetch("DECIDIM_ADMIN_PASSWORD_STRONG", nil)
  # When the strong password is not configured, default to true
  config.admin_password_strong = admin_password_strong.nil? ? true : admin_password_strong.present?
  config.admin_password_expiration_days = ENV.fetch("DECIDIM_ADMIN_PASSWORD_EXPIRATION_DAYS", "90").to_i
  config.admin_password_min_length = ENV.fetch("DECIDIM_ADMIN_PASSWORD_MIN_LENGTH", "15").to_i
  config.admin_password_repetition_times = ENV.fetch("DECIDIM_ADMIN_PASSWORD_REPETITION_TIMES", "5").to_i

  # Additional optional configurations (see decidim-core/lib/decidim/core.rb)
  config.cache_key_separator = ENV["DECIDIM_CACHE_KEY_SEPARATOR"] if ENV["DECIDIM_CACHE_KEY_SEPARATOR"].present?
  config.cache_expiry_time = ENV["DECIDIM_CACHE_EXPIRY_TIME"].to_i.minutes if ENV["DECIDIM_CACHE_EXPIRY_TIME"].present?
  config.stats_cache_expiry_time = ENV["DECIDIM_STATS_CACHE_EXPIRY_TIME"].to_i.minutes if ENV["DECIDIM_STATS_CACHE_EXPIRY_TIME"].present?
  config.expire_session_after = ENV["DECIDIM_EXPIRE_SESSION_AFTER"].to_i.minutes if ENV["DECIDIM_EXPIRE_SESSION_AFTER"].present?
  config.enable_remember_me = ENV["DECIDIM_ENABLE_REMEMBER_ME"] == "true" if ENV["DECIDIM_ENABLE_REMEMBER_ME"].present? && ENV["DECIDIM_ENABLE_REMEMBER_ME"] != "auto"
  config.session_timeout_interval = ENV["DECIDIM_SESSION_TIMEOUT_INTERVAL"].to_i.seconds if ENV["DECIDIM_SESSION_TIMEOUT_INTERVAL"].present?
  config.follow_http_x_forwarded_host = ENV["DECIDIM_FOLLOW_HTTP_X_FORWARDED_HOST"].present?
  config.maximum_conversation_message_length = ENV.fetch("DECIDIM_MAXIMUM_CONVERSATION_MESSAGE_LENGTH", "1000").to_i
  config.password_blacklist = ENV["DECIDIM_PASSWORD_BLACKLIST"].split(",").map(&:strip) if ENV["DECIDIM_PASSWORD_BLACKLIST"].present?
  config.allow_open_redirects = ENV["DECIDIM_ALLOW_OPEN_REDIRECTS"].present? if ENV["DECIDIM_ALLOW_OPEN_REDIRECTS"].present?

  if ENV["SMS_SERVICE_URL"].present? && ENV["SMS_USERNAME"].present? && ENV["SMS_PASSWORD"].present?
    config.sms_gateway_service = "SmsGateway"

    Decidim::Verifications.register_workflow(:census_sms_authorization_handler) do |auth|
      auth.engine = Decidim::CensusSms::Verification::Engine
      auth.renewable = true
      auth.time_between_renewals = 1.day
      # Uncomment the following line to make the workflow ephemeral
      # auth.ephemeral = true
    end
  end
end

if Decidim.module_installed? :api
  Decidim::Api.configure do |config|
    config.schema_max_per_page = ENV.fetch("DECIDIM_API_SCHEMA_MAX_PER_PAGE", "50").to_i
    config.schema_max_complexity = ENV.fetch("DECIDIM_API_SCHEMA_MAX_COMPLEXITY", "5000").to_i
    config.schema_max_depth = ENV.fetch("DECIDIM_API_SCHEMA_MAX_DEPTH", "15").to_i
  end
end

if Decidim.module_installed? :proposals
  Decidim::Proposals.configure do |config|
    config.similarity_threshold = ENV.fetch("DECIDIM_PROPOSALS_SIMILARITY_THRESHOLD", "0.25").to_f
    config.similarity_limit = ENV.fetch("DECIDIM_PROPOSALS_SIMILARITY_LIMIT", "10").to_i
    config.participatory_space_highlighted_proposals_limit = ENV.fetch("DECIDIM_PROPOSALS_PARTICIPATORY_SPACE_HIGHLIGHTED_LIMIT", "4").to_i
    config.process_group_highlighted_proposals_limit = ENV.fetch("DECIDIM_PROPOSALS_PROCESS_GROUP_HIGHLIGHTED_LIMIT", "3").to_i
  end
end

if Decidim.module_installed? :meetings
  Decidim::Meetings.configure do |config|
    config.upcoming_meeting_notification = ENV.fetch("DECIDIM_MEETINGS_UPCOMING_NOTIFICATION", "2").to_i.days
    config.embeddable_services = ENV["DECIDIM_MEETINGS_EMBEDDABLE_SERVICES"].split(",").map(&:strip) if ENV["DECIDIM_MEETINGS_EMBEDDABLE_SERVICES"].present?
    config.enable_proposal_linking = ENV["DECIDIM_MEETINGS_ENABLE_PROPOSAL_LINKING"].present? unless ENV["DECIDIM_MEETINGS_ENABLE_PROPOSAL_LINKING"] == "auto"
  end
end

if Decidim.module_installed? :budgets
  Decidim::Budgets.configure do |config|
    config.enable_proposal_linking = ENV["DECIDIM_BUDGETS_ENABLE_PROPOSAL_LINKING"].present? unless ENV["DECIDIM_BUDGETS_ENABLE_PROPOSAL_LINKING"] == "auto"
  end
end

if Decidim.module_installed? :initiatives
  Decidim::Initiatives.configure do |config|
    config.creation_enabled = ENV["DECIDIM_INITIATIVES_CREATION_ENABLED"].present? unless ENV["DECIDIM_INITIATIVES_CREATION_ENABLED"] == "auto"
    config.similarity_threshold = ENV.fetch("DECIDIM_INITIATIVES_SIMILARITY_THRESHOLD", "0.25").to_f
    config.similarity_limit = ENV.fetch("DECIDIM_INITIATIVES_SIMILARITY_LIMIT", "5").to_i
    config.minimum_committee_members = ENV.fetch("DECIDIM_INITIATIVES_MINIMUM_COMMITTEE_MEMBERS", "2").to_i
    config.default_signature_time_period_length = ENV.fetch("DECIDIM_INITIATIVES_DEFAULT_SIGNATURE_TIME_PERIOD_LENGTH", "120").to_i
    config.default_components = ENV["DECIDIM_INITIATIVES_DEFAULT_COMPONENTS"].split(",").map(&:strip) if ENV["DECIDIM_INITIATIVES_DEFAULT_COMPONENTS"].present?
    config.first_notification_percentage = ENV.fetch("DECIDIM_INITIATIVES_FIRST_NOTIFICATION_PERCENTAGE", "33").to_i
    config.second_notification_percentage = ENV.fetch("DECIDIM_INITIATIVES_SECOND_NOTIFICATION_PERCENTAGE", "66").to_i
    config.stats_cache_expiration_time = ENV.fetch("DECIDIM_INITIATIVES_STATS_CACHE_EXPIRATION_TIME", "5").to_i.minutes
    config.max_time_in_validating_state = ENV.fetch("DECIDIM_INITIATIVES_MAX_TIME_IN_VALIDATING_STATE", "0").to_i.days
    config.print_enabled = ENV["DECIDIM_INITIATIVES_PRINT_ENABLED"].present? unless ENV["DECIDIM_INITIATIVES_PRINT_ENABLED"] == "auto"
    config.do_not_require_authorization = ENV["DECIDIM_INITIATIVES_DO_NOT_REQUIRE_AUTHORIZATION"].present?
  end
end

if Decidim.module_installed? :elections
  Decidim::Elections.configure do |config|
    config.setup_minimum_hours_before_start = ENV.fetch("ELECTIONS_SETUP_MINIMUM_HOURS_BEFORE_START", "3").to_i
    config.start_vote_maximum_hours_before_start = ENV.fetch("ELECTIONS_START_VOTE_MAXIMUM_HOURS_BEFORE_START", "6").to_i
    config.voter_token_expiration_minutes = ENV.fetch("ELECTIONS_VOTER_TOKEN_EXPIRATION_MINUTES", "120").to_i
  end

  Decidim::Votings.configure do |config|
    config.check_census_max_requests = ENV.fetch("ELECTIONS_VOTINGS_CHECK_CENSUS_MAX_REQUESTS", "5").to_i
    config.throttling_period = ENV.fetch("ELECTIONS_VOTINGS_THROTTLING_PERIOD", "1").to_i.minutes
  end

  Decidim::Votings::Census.configure do |config|
    config.census_access_codes_export_expiry_time = ENV.fetch("ELECTIONS_VOTINGS_CENSUS_ACCESS_CODES_EXPORT_EXPIRY_TIME", "2").to_i.days
  end
end

if Decidim.module_installed? :verifications
  Decidim::Verifications.configure do |config|
    config.document_types = if ENV["VERIFICATIONS_DOCUMENT_TYPES"].present?
                              ENV["VERIFICATIONS_DOCUMENT_TYPES"].split(",").map(&:strip)
                            else
                              %w(identification_number passport)
                            end
  end
end

Rails.application.config.i18n.available_locales = Decidim.available_locales
Rails.application.config.i18n.default_locale = Decidim.default_locale

# Inform Decidim about the assets folder
Decidim.register_assets_path File.expand_path("app/packs", Rails.application.root)

Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
  auth.form = "CensusAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_authorization_metadata"
  # Uncomment the following line to make the workflow ephemeral
  # auth.ephemeral = true

  auth.options do |options|
    district_codes = %w(1 2 3 4 5 6 7 8 9 10)

    district_codes.each do |code|
      options.attribute :"scope_code_#{code}", type: :boolean, required: false
    end
  end

  auth.action_authorizer = "CensusActionAuthorizer"
end

Decidim::Verifications.register_workflow(:census16_authorization_handler) do |auth|
  auth.form = "Census16AuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census16_authorization_metadata"
  # Uncomment the following line to make the workflow ephemeral
  # auth.ephemeral = true
end

Decidim::Verifications.register_workflow(:census_kids_authorization_handler) do |auth|
  auth.form = "CensusKidsAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_kids_authorization_metadata"
end

Decidim::Verifications.register_workflow(:census_sarria_sant_gervasi_authorization_handler) do |auth|
  auth.form = "CensusSarriaSantGervasiAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "census_sarria_sant_gervasi_authorization_metadata"
  # Uncomment the following line to make the workflow ephemeral
  # auth.ephemeral = true
end

Decidim::Verifications.register_workflow(:ephemeral_census_authorization_handler) do |auth|
  auth.form = "EphemeralCensusAuthorizationHandler"
  auth.renewable = true
  auth.time_between_renewals = 1.day
  auth.metadata_cell = "ephemeral_census_authorization_metadata"
  auth.ephemeral = true
end

Decidim.icons.register(name: "arrow-bottom", icon: "arrow-bottom", category: "system", description: "", engine: :core)
Decidim.icons.register(name: "audio", icon: "audio", category: "system", description: "", engine: :core)
Decidim.icons.register(name: "fingerprint-2-line", icon: "fingerprint-2-line", category: "system", description: "", engine: :core)
Decidim.icons.register(name: "link-intact", icon: "link-intact", category: "system", description: "", engine: :core)
Decidim.icons.register(name: "route-line", icon: "route-line", category: "system", description: "", engine: :core)
