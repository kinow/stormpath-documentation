client = Stormpath::Client.new(
  api_key_file_location: api_key_file_location,
  cache: {
    store: Stormpath::Cache::DisabledCacheStore
  }
)
