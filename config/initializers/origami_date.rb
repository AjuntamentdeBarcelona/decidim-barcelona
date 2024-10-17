# frozen_string_literal: true

require "English"

# Fix error: ArgumentError (wrong number of arguments (given 1, expected 0; required keyword: year))
# @see https://github.com/gdelugre/origami/issues/80
module Origami
  class Date < LiteralString
    def self.parse(str)
      raise InvalidDateError, "Not a valid Date string" unless str =~ REGEXP_TOKEN

      date = { year: $LAST_MATCH_INFO["year"].to_i }

      date[:month] = $LAST_MATCH_INFO["month"].to_i if $LAST_MATCH_INFO["month"]
      date[:day] = $LAST_MATCH_INFO["day"].to_i if $LAST_MATCH_INFO["day"]
      date[:hour] = $LAST_MATCH_INFO["hour"].to_i if $LAST_MATCH_INFO["hour"]
      date[:min] = $LAST_MATCH_INFO["min"].to_i if $LAST_MATCH_INFO["min"]
      date[:sec] = $LAST_MATCH_INFO["sec"].to_i if $LAST_MATCH_INFO["sec"]

      if %w(+ -).include?($LAST_MATCH_INFO["ut"])
        utc_offset = ($LAST_MATCH_INFO["ut_hour_off"].to_i * 3600) + ($LAST_MATCH_INFO["ut_min_off"].to_i * 60)
        utc_offset = -utc_offset if $LAST_MATCH_INFO["ut"] == "-"

        date[:utc_offset] = utc_offset
      end

      Origami::Date.new(**date)
    end

    def self.now
      now = Time.now.utc

      date = { year: now.strftime("%Y").to_i, month: now.strftime("%m").to_i, day: now.strftime("%d").to_i,
               hour: now.strftime("%H").to_i, min: now.strftime("%M").to_i, sec: now.strftime("%S").to_i,
               utc_offset: now.utc_offset }

      Origami::Date.new(**date)
    end
  end
end
