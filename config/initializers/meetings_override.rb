# frozen_string_literal: true

# Hack to allow custom url for online iframes (Note: create a fix PR for Decidim with a configurable var for this)
Rails.application.config.to_prepare do
  Decidim::Meetings::MeetingIframeEmbedder.class_eval do
    Decidim::Meetings::MeetingIframeEmbedder.send(:remove_const, :EMBEDDABLE_SERVICES)
    Decidim::Meetings::MeetingIframeEmbedder.const_set(:EMBEDDABLE_SERVICES, %( www.youtube.com www.twitch.tv meet.jit.si salavirtual.barcelona.cat ))
  end
end
