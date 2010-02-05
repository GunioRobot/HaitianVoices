# just like development environment, but to be used when one
# is coding in a disconnected environment (airplane, coffee shop, etc.)

eval File.read(File.expand_path('../development.rb', __FILE__))

Recaptcha::Verify::class_eval do
  def verify_recaptcha(*args)
    return true
  end
end
