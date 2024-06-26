# frozen_string_literal: true

Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: Rails.application.credentials.Maps_API_Key,
  units: :km
)
