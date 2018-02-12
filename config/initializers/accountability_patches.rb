# frozen_string_literal: true

Decidim::Accountability::Admin::UpdateResult.class_eval do
  def update_result
    Decidim.traceability.update!(
      result,
      form.current_user,
      scope: @form.scope,
      category: @form.category,
      parent_id: @form.parent_id,
      title: @form.title,
      description: @form.description,
      start_date: @form.start_date,
      end_date: @form.end_date,
      progress: @form.progress,
      decidim_accountability_status_id: @form.decidim_accountability_status_id,
      external_id: @form.external_id.blank? ? nil : @form.external_id,
      weight: @form.weight
    )
  end
end

Decidim::Accountability::Admin::CreateResult.class_eval do
  def create_result
    @result = Decidim.traceability.create!(
      Decidim::Accountability::ResultWithWeightedProgress,
      @form.current_user,
      feature: @form.current_feature,
      scope: @form.scope,
      category: @form.category,
      parent_id: @form.parent_id,
      title: @form.title,
      description: @form.description,
      start_date: @form.start_date,
      end_date: @form.end_date,
      progress: @form.progress,
      decidim_accountability_status_id: @form.decidim_accountability_status_id,
      external_id: @form.external_id.blank? ? nil : @form.external_id,
      weight: @form.weight
    )
    end
end

Decidim::Accountability::Admin::ResultForm.class_eval do
  attribute :external_id, String
  attribute :weight, Float

  _validators[:description]
    .find { |v| v.is_a? TranslatablePresenceValidator }
    .attributes
    .delete(:description)
end
