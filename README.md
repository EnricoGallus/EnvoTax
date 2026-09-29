# EnvoTax

[![CI](https://github.com/EnricoGallus/EnvoTax/actions/workflows/ci.yml/badge.svg)](https://github.com/EnricoGallus/EnvoTax/actions/workflows/ci.yml)

EnvoTax is a Rails app for the paperwork side of freelancing: tracking time and expenses,
turning them into invoices, and matching incoming payments against those invoices.
I built it for my own freelance work and use it to bill my clients.

<!-- TODO: add screenshots (dashboard, invoice preview, payment allocation) to docs/screenshots/ and link them here -->

## What it does

- **Time tracking.** Log time against client projects; overlapping entries are rejected and the cost is
  calculated from the client's hourly rate. The dashboard shows today, the current week and month
  (with charts), unbilled time and outstanding invoices.
- **Contracts.** Clients have contracts, split into dated periods with optional budget limits.
- **Invoicing.** Pick a date range and a background job creates an invoice per contract, pulling in the
  unbilled time entries and expenses from that range. The total is either the sum of each entry's cost or
  total hours × hourly rate, depending on the client. Invoice numbers run per client and year
  (`2026-0001`), and drafts can be previewed before they're approved.
- **Expenses.** Record expenses by cost type, as charges or credits, with the receipt attached.
- **Payments.** Record an incoming payment, then allocate it across invoices and adjustments (bonuses,
  deductions). Each allocation records the withholding tax the client deducted, and invoices move to
  partially paid or paid on their own.
- **English and Japanese UI.**

## Tech stack

| Area              | Choice                                                                          |
|-------------------|---------------------------------------------------------------------------------|
| Framework         | Ruby 3.4, Rails 8.1                                                             |
| Database          | PostgreSQL 17                                                                   |
| Frontend          | Hotwire (Turbo, Stimulus), Tailwind CSS, ViewComponent, Chartkick               |
| Background jobs   | Solid Queue (plus Solid Cache and Solid Cable, so no Redis)                     |
| Auth              | Devise for authentication, Pundit for authorization                             |
| Money             | money-rails                                                                     |
| Search and paging | Ransack, Pagy                                                                   |
| Monitoring        | Sentry                                                                          |
| Hosting           | Kamal 2 and Thruster on a single arm64 EC2 instance, images in ECR, files on S3 |

## Tests and CI

The RSpec suite covers models, services, policies, requests, routing, components, views and
system tests (Capybara with headless Chrome).

GitHub Actions runs on every push and pull request:

- RSpec
- RuboCop (including RSpec, Rails, i18n and Markdown rules)
- Brakeman and bundler-audit
- i18n-tasks, to catch missing or unused translations
- an asset precompile check

## Running it locally

### 1. Get the dependencies

**With the dev container (easiest).** Open the project in VS Code and choose
*Reopen in Container*. It starts Postgres and installs the gems and JavaScript packages.

**Without it.** You need Ruby 3.4.7, Node 24 with Yarn, and Docker for Postgres:

```bash
docker compose up -d db
export DATABASE_HOST=localhost
bundle install
yarn install
```

### 2. Create a login

There's no sign-up page. The seed creates the user from Rails credentials, and since
`config/master.key` isn't in the repository, create development credentials of your own:

```bash
EDITOR="code --wait" bin/rails credentials:edit --environment development
```

```yaml
user:
  email: you@example.com
  name: Your Name
  password: choose-a-password
```

### 3. Set up and start

```bash
bin/setup
```

This creates and seeds the database, then starts the app at <http://localhost:3001>.

### Running the tests

```bash
bin/ci
```

## Deployment

Production runs on a single arm64 EC2 instance, deployed with Kamal. Postgres runs as a Kamal
accessory on the same host and uploads go to S3. The runbook is in
[docs/deployment.md](docs/deployment.md).

## Scope

EnvoTax is shaped around my own workflow: amounts default to Japanese yen and the preset tax rates
are Japanese withholding rates. It isn't meant as a general-purpose product, but feel free to fork it.

## License

[MIT](LICENSE)
