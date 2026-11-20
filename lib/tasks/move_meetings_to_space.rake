# frozen_string_literal: true

namespace :meetings do
  # Moves meetings to a meetings component of another participatory space.
  #
  # Each meeting is moved with `update!` so its search index is refreshed, and the
  # participatory space stored in its comments and moderations (of the meeting and
  # of its comments) is updated too, so admins of the new space can moderate them.
  #
  # Without APPLY=1 it only reports what would change: the target component, the
  # meetings, and the links, taxonomies and categories that will need a look after
  # the move. Nothing is written.
  #
  #   bin/rails meetings:move_to_space MEETING_IDS=7644,7845 TARGET_ASSEMBLY=grupstreball-consellbenestaranimal
  #   bin/rails meetings:move_to_space MEETING_IDS=7644,7845 TARGET_COMPONENT=1234 APPLY=1
  #
  # TARGET_ASSEMBLY picks the only meetings component of that assembly. If it has
  # none or more than one, the task stops and TARGET_COMPONENT must be given.
  desc "Move meetings to another space's meetings component (dry run unless APPLY=1)"
  task move_to_space: :environment do
    MoveMeetingsToSpace.new(
      meeting_ids: ENV.fetch("MEETING_IDS", "").split(",").map(&:strip).compact_blank.map(&:to_i),
      target_component_id: ENV.fetch("TARGET_COMPONENT", nil).presence,
      target_assembly_slug: ENV.fetch("TARGET_ASSEMBLY", nil).presence,
      apply: ENV["APPLY"] == "1"
    ).call
  end
end

class MoveMeetingsToSpace
  def initialize(meeting_ids:, target_component_id:, target_assembly_slug:, apply:)
    @meeting_ids = meeting_ids
    @target_component_id = target_component_id
    @target_assembly_slug = target_assembly_slug
    @apply = apply
  end

  def call
    abort "MEETING_IDS is required, ie: MEETING_IDS=7644,7845" if @meeting_ids.empty?

    @target_component = find_target_component
    @target_space = @target_component.participatory_space
    @meetings = Decidim::Meetings::Meeting.where(id: @meeting_ids).includes(:component).order(:id).to_a
    @comments = Decidim::Comments::Comment.where(root_commentable: @meetings).order(:id).to_a
    @moderations = Decidim::Moderation.where(reportable: @meetings)
                                      .or(Decidim::Moderation.where(reportable: @comments))
                                      .order(:id).to_a

    report_target
    report_meetings
    report_comments_and_moderations
    report_links
    report_taxonomies
    report_categories
    check_validity

    if @apply
      move!
    else
      puts "\nDry run. Nothing was written. Re-run with APPLY=1 to move the meetings."
    end
  end

  private

  def find_target_component
    return Decidim::Component.find(@target_component_id).tap { |c| check_meetings_component!(c) } if @target_component_id

    abort "TARGET_COMPONENT or TARGET_ASSEMBLY is required" unless @target_assembly_slug

    assembly = Decidim::Assembly.find_by!(slug: @target_assembly_slug)
    components = assembly.components.where(manifest_name: "meetings").order(:id).to_a
    case components.size
    when 1 then components.first
    when 0 then abort "Assembly #{assembly.slug} (#{assembly.id}) has no meetings component. Create one first."
    else
      abort "Assembly #{assembly.slug} has several meetings components (#{components.map { |c| "#{c.id} #{name(c)}" }.join(", ")}). " \
            "Choose one with TARGET_COMPONENT."
    end
  end

  def check_meetings_component!(component)
    return if component.manifest_name == "meetings"

    abort "Component #{component.id} is a #{component.manifest_name} component, not a meetings one."
  end

  def report_target
    puts "== Target"
    puts "  #{space_label(@target_space)}"
    puts "    published: #{@target_space.published?}  private: #{@target_space.try(:private_space?) || false}"
    puts "  meetings component #{@target_component.id} #{name(@target_component)}  published: #{@target_component.published?}"
    warn_line "the target component is not published, moved meetings will not be visible" unless @target_component.published?
    warn_line "the target space is not published" unless @target_space.published?
  end

  def report_meetings
    puts "\n== Meetings (#{@meetings.size} of #{@meeting_ids.size} requested)"
    missing = @meeting_ids - @meetings.map(&:id)
    abort "  Meetings not found: #{missing.join(", ")}. Nothing was written." if missing.any?

    @meetings.each do |meeting|
      flags = meeting_flags(meeting)
      puts "  #{meeting.id} #{name(meeting).truncate(60)}"
      puts "    from #{space_label(meeting.participatory_space)}, component #{meeting.decidim_component_id}#{" [#{flags.join(", ")}]" if flags.any?}"
    end

    spaces = @meetings.map(&:participatory_space).uniq
    warn_line "the meetings come from #{spaces.size} different spaces" if spaces.size > 1
  end

  def meeting_flags(meeting)
    {
      "UNPUBLISHED" => !meeting.published?,
      "WITHDRAWN" => meeting.withdrawn_at.present?,
      "DELETED" => meeting.deleted_at.present?,
      "HIDDEN" => meeting.hidden?,
      "ALREADY IN TARGET" => meeting.decidim_component_id == @target_component.id
    }.select { |_flag, on| on }.keys
  end

  def report_comments_and_moderations
    puts "\n== Comments and moderations to move to the target space"
    puts "  comments: #{@comments.size}"
    puts "  moderations: #{@moderations.size} (#{@moderations.count { |m| m.hidden_at.present? }} hidden)"
  end

  # Links are kept, but Decidim only shows linked resources from the same space
  # (Resourceable#sibling_scope), so links to resources of other spaces stop showing.
  def report_links
    links = Decidim::ResourceLink.where(from: @meetings).or(Decidim::ResourceLink.where(to: @meetings)).order(:id)
    puts "\n== Resource links (#{links.count})"

    links.each do |link|
      from_meeting = link.from_type == "Decidim::Meetings::Meeting" && @meeting_ids.include?(link.from_id)
      meeting_id, other_type, other_id = from_meeting ? [link.from_id, link.to_type, link.to_id] : [link.to_id, link.from_type, link.from_id]
      other = from_meeting ? link.to : link.from
      other_space = other.try(:participatory_space)
      status = if other.nil? then "linked resource no longer exists"
               elsif other_space == @target_space then "ok, same space as target"
               else
                 "WILL STOP SHOWING (other space: #{other_space ? space_label(other_space) : "none"})"
               end
      puts "  meeting #{meeting_id} <-#{link.name}-> #{other_type} #{other_id}: #{status}"
    end

    meeting_links = Decidim::Meetings::MeetingLink.where(meeting: @meetings)
    puts "  meeting_links to other components: #{meeting_links.count}" if meeting_links.exists?
  end

  # Taxonomies belong to the organization, so they stay valid. What changes is
  # whether the target component's taxonomy filters include them.
  def report_taxonomies
    filter_taxonomy_ids = @target_component.available_taxonomy_filters.flat_map(&:filter_taxonomy_ids)
    puts "\n== Taxonomies"
    puts "  target component taxonomy filters: #{@target_component.available_taxonomy_filters.map { |f| "#{f.id} #{translated(f.internal_name)}" }.join(", ").presence || "none"}"

    @meetings.each do |meeting|
      next if meeting.taxonomies.empty?

      taxonomies = meeting.taxonomies.map { |taxonomy| taxonomy_label(taxonomy, filter_taxonomy_ids) }
      puts "  #{meeting.id}: #{taxonomies.join("; ")}"
    end

    untagged = @meetings.count { |m| m.taxonomies.empty? }
    puts "  meetings without taxonomies: #{untagged}" if untagged.positive?
  end

  def taxonomy_label(taxonomy, filter_taxonomy_ids)
    label = "#{taxonomy.id} #{translated(taxonomy.name)}"
    filter_taxonomy_ids.include?(taxonomy.id) ? label : "#{label} (not in target filters)"
  end

  # Legacy categories belong to a participatory space, so a moved meeting would
  # keep a category of the source space.
  def report_categories
    categorized = @meetings.select(&:category)
    return if categorized.empty?

    puts "\n== Legacy categories (belong to the source space)"
    categorized.each { |m| puts "  #{m.id}: category #{m.category.id} #{translated(m.category.name)}" }
  end

  def check_validity
    invalid = []
    @meetings.each do |meeting|
      meeting.component = @target_component
      invalid << "meeting #{meeting.id}: #{meeting.errors.full_messages.to_sentence}" unless meeting.valid?
      meeting.restore_attributes
      meeting.association(:component).reset
    end
    @comments.each do |comment|
      comment.participatory_space = @target_space
      invalid << "comment #{comment.id}: #{comment.errors.full_messages.to_sentence}" unless comment.valid?
      comment.restore_attributes
      comment.association(:participatory_space).reset
    end
    return if invalid.empty?

    puts "\n== Records that would fail validation"
    invalid.each { |line| puts "  #{line}" }
    abort "Fix them before moving. Nothing was written."
  end

  def move!
    puts "\n== Moving"
    ActiveRecord::Base.transaction do
      @comments.each { |comment| comment.update!(participatory_space: @target_space) }
      @moderations.each { |moderation| moderation.update!(participatory_space: @target_space) }
      @meetings.each do |meeting|
        meeting.update!(component: @target_component)
        puts "  moved meeting #{meeting.id}"
      end
    end
    puts "Moved #{@meetings.size} meetings, #{@comments.size} comments and #{@moderations.size} moderations " \
         "to #{space_label(@target_space)}, component #{@target_component.id}."
  end

  def space_label(space)
    "#{space.class.name.demodulize} #{space.id} #{space.try(:slug)} (#{translated(space.title).truncate(60)})"
  end

  def name(resource)
    translated(resource.try(:title) || resource.try(:name))
  end

  def translated(value)
    return value.to_s unless value.is_a?(Hash)

    value["ca"].presence || value["es"].presence || value.values.grep(String).first.to_s
  end

  def warn_line(message)
    puts "  ! #{message}"
  end
end
