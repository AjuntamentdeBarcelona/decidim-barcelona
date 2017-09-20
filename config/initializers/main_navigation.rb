Decidim.menu :menu do |menu|
  if current_organization.host == "localhost"
    menu.item I18n.t("menu.accountability_static"),
              DecidimBarcelona::Application.routes.url_helpers.accountability_static_path,
              position: 4,
              active: :inclusive
  end
end
