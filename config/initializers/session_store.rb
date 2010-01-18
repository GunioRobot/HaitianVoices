# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_haitianstories_session',
  :secret      => '0283e0e1eb92a3d6bcd8b44cd8bc45fcaf34d61f2414968037b0488a75566dc0edd33a7b4774797bf93c348fc5337012c41cec4b1eb755bdf39a8bea1c5086a4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
