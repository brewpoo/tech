# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails232-app_session',
  :secret      => '9ef123c413235ca9a8fbf228cfb0d22966f49cb1b61e1d7247f00cd8daf75bf40b20ab479a7617c3416a04b8a913f8ceb4584cb54189434581ade42ee737a465'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
