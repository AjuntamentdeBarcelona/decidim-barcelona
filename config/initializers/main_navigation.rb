Decidim.menu :menu do |menu|
  menu.item I18n.t("menu.accountability_static"),
            DecidimBarcelona::Application.routes.url_helpers.accountability_static_path,
            position: 4,
            active: :inclusive
end
