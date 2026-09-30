# frozen_string_literal: true

# Run using bin/ci
ENV["RAILS_ENV"] = "test"

CI.run do
  step "Setup", "bin/setup --skip-server"

  step "Style: Ruby", "bin/rubocop"
  step "Style I18n", "bundle exec i18n-tasks health"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: JavaScript dependency audit", "yarn audit"
  step "Security: Brakeman code analysis", "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Tests: Rspec", "bundle exec rspec"
  step "Tests: Seeds", "bin/rails db:seed:replant"
end
