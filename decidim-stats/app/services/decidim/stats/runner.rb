# frozen_string_literal: true

module Decidim
  module Stats
    class Runner
      def initialize(minimum_count:, component_ids: [])
        @minimum_count = minimum_count
        @component_ids = component_ids
      end

      def run
        components.each do |component|
          next unless component.participatory_space

          performers.each do |performer_klass|
            performer_klass.available_sections.each do |performer_section|
              performers_ids = []

              actions.each do |action_klass|
                key = build_key(component, action_klass, performer_klass, performer_section)

                users = performer_users(performer_klass, performer_section)
                action = action_klass.new(component, users)
                action_performer_ids = action.query.to_a
                performers_ids += action_performer_ids

                stats_data[key] = action_performer_ids.count
              end

              interactions_key = build_key(component, :interactions, performer_klass, performer_section)
              stats_data[interactions_key] = performers_ids.uniq.count
            end
          end
        end

        stats_data.select { |_k, v| v >= minimum_count }
      end

      private

      attr_reader :minimum_count, :component_ids

      def actions
        [
          Decidim::Stats::Actions::Comment,
          Decidim::Stats::Actions::Endorsement,
          Decidim::Stats::Actions::Follow,
          Decidim::Stats::Actions::ProposalCreation,
          Decidim::Stats::Actions::ProposalVote
        ]
      end

      def performers
        [
          Decidim::Stats::Performers::AgeGroup,
          Decidim::Stats::Performers::District,
          Decidim::Stats::Performers::Gender
        ]
      end

      def performer_users_cache
        @performer_users_cache ||= {}
      end

      def performer_users(klass, section)
        performer_users_cache[[klass, section]] ||= klass.new(section).query
      end

      def components
        @components ||= Decidim::Component.unscoped.order(id: :asc)
        component_ids.any? ? @components.where(id: component_ids) : @components
      end

      def pretty_klass_name(klass)
        klass.name.demodulize.underscore
      end

      def stats_data
        @stats_data ||= {}
      end

      def build_key(component, action_klass, performer_klass, performer_section)
        [
          component.participatory_space.manifest.name,
          component.participatory_space.id,
          component.id,
          action_klass.is_a?(Class) ? pretty_klass_name(action_klass).to_sym : action_klass,
          pretty_klass_name(performer_klass).to_sym,
          performer_section
        ]
      end
    end
  end
end
