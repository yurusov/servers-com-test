# frozen_string_literal: true

Factory.define(:ip_address) do |f|
  f.value { fake(:internet, :ip_v4_address) }
  f.enabled true

  f.trait :ipv6 do |t|
    t.value { fake(:internet, :ip_v6_address) }
  end

  f.trait :disabled do |t|
    t.enabled false
  end
end
