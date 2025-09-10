# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20181107175558)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddQuestionnaireToExistingMeetings < ActiveRecord::Migration[5.2]
  def change
    Decidim::Meetings::Meeting.transaction do
      Decidim::Meetings::Meeting.unscoped.find_each do |meeting|
        if meeting.component.present? && meeting.questionnaire.blank?
          meeting.update!(
            questionnaire: Decidim::Forms::Questionnaire.new
          )
        end
      end
    end
  end
end
