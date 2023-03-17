# frozen_string_literal: true

module Decidim
  module Meetings
    module MeetingOverride
      extend ActiveSupport::Concern

      included do
        def visible_for_admin_user?(user)
          return if user.blank?

          table_name = component.participatory_space.class.table_name
          roles_table = "#{table_name.singularize}_user_roles"
          return unless ActiveRecord::Base.connection.table_exists?(roles_table)

          query = "SELECT decidim_user_id FROM #{roles_table} WHERE decidim_user_id = #{user.id}
                   AND #{table_name.singularize}_id = #{component.participatory_space.id} AND role = 'admin'"
          result = ActiveRecord::Base.connection.execute(query)
          result.first
        end
      end
    end
  end
end
