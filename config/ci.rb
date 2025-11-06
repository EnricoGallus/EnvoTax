# frozen_string_literal: true

# Run using bin/ci

CI.run do
  step "Setup Docker", "docker-compose up -d"
  step "Setup", "env RAILS_ENV=test bin/setup --skip-server"

  step "Style: Ruby", "bin/rubocop"
  step "Style I18n", "bundle exec i18n-tasks health"

  step "Security: Gem audit", "bin/bundler-audit"
  step "Security: Brakeman code analysis", "bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error"

  step "Tests: Rspec", "bundle exec rspec"
  step "Tests: Seeds", "env RAILS_ENV=test bin/rails db:seed:replant"
end
