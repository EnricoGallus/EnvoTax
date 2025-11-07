# frozen_string_literal: true

FactoryBot.define do
  sequence(:_time_entry_seq) { |n| n }

  factory :time_entry do
    project
    sequence(:name) { |n| "Task #{n}" }

    # --- Deterministic, non-overlapping config ---
    transient do
      slot_index { 0 }             # 0,1,2,...
      slot_minutes { 60 }          # default duration
      slot_stride_minutes { 480 }  # 8h spacing → no overlap even with long durations
      first_hour { 9 }             # base start time in the day
      day_offset { 0 }             # shift the calendar day if needed
    end

    date { Time.zone.today + day_offset.days }

    time_from do
      base = date.in_time_zone.change(hour: first_hour, min: 0, sec: 0)
      base + (slot_index * slot_stride_minutes).minutes
    end

    time_to { time_from + slot_minutes.minutes }

    trait :sequential do
      # auto-assigns a unique slot per created record (within a spec example)
      slot_index { generate(:_time_entry_seq) }
    end

    trait :with_duration do
      transient do
        hours { 2 }
        minutes { 0 }
        start_hour { nil }
      end

      time_from do
        base =
          if start_hour
            date.in_time_zone.change(hour: start_hour, min: 0, sec: 0)
          else
            date.in_time_zone.change(hour: first_hour, min: 0, sec: 0)
          end
        base + (slot_index * slot_stride_minutes).minutes
      end

      time_to { time_from + hours.hours + minutes.minutes }
    end

    trait :yesterday do
      day_offset { -1 }
    end

    trait :tomorrow do
      day_offset { 1 }
    end
  end
end
