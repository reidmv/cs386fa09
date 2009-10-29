# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_386_session',
  :secret      => '02ba6b933654334c3fdb2b54409cd5fd3c05e991bd892f435d672518e5433faa8292c586df91ebe0248948a59a704b2d9bb9272d47534e8b3f729e42fb3ea7d8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
