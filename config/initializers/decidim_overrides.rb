# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Initiatives::InitiativeMCell.prepend Decidim::Overrides::Initiatives::InitiativeMCell
  Decidim::Accountability::Result.include(Decidim::Accountability::ResultOverride)
  Decidim::Accountability::ResultsCalculator.include(Decidim::Accountability::ResultsCalculatorOverride)
  Decidim::Meetings::Meeting.include(Decidim::Meetings::MeetingOverride)
  Decidim::Meetings::MeetingsController.include(Decidim::Meetings::MeetingsControllerOverride)
  Decidim::Meetings::OnlineMeetingCell.include(Decidim::Meetings::OnlineMeetingCellOverride)
  Decidim::Meetings::MeetingsHelper.include(Decidim::Meetings::MeetingsHelperOverride)
end
