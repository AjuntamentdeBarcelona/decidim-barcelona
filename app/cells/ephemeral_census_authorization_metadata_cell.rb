# frozen_string_literal: true

# This cell is to render the census authorization metadata in the renew modal
class EphemeralCensusAuthorizationMetadataCell < Decidim::Verifications::AuthorizationMetadataCell
  private

  def metadata_key(data)
    data[0] = "scope_id" if data.first == "scope"
    super
  end

  def metadata_value(data)
    value = data.second
    value = l(value.to_date, format: :decidim_short) if data.first == "date_of_birth"

    if %w(man non_binary woman).include?(value)
      t(value, scope: "#{authorization_name}.form.genders")
    else
      value
    end
  end

  def authorization_name
    @authorization_name ||= model.name.chomp("_handler")
  end
end
