# frozen_string_literal: true

# helper for time entries
# This module provides helper methods for formatting time entries in the application.
# It includes methods to format spent time in a human-readable format.
module TimeEntriesHelper
  def format_spent_time(time_in_seconds)
    seconds = time_in_seconds
    hours = seconds / 1.hour
    minutes = (seconds % 1.hour) / 1.minute

    format("%<hours>02dh:%<minutes>02dm", hours: hours, minutes: minutes)
  end
end
