# frozen_string_literal: true

Factory.define(:statistics) do |f|
  # f.association(:ip_address)
  f.ip_address { Factory[:ip_address].value } # otherwise association fails with type missmatch

  f.start_time { fake(:time, :between_dates, from: DateTime.now - 1, to: DateTime.now) }
  f.rtt { Random.rand(999) }
  f.failed false

  f.trait :failed do |t|
    t.failed true
    t.rtt nil
  end
end
