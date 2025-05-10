# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss-animate" # @1.0.7
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @4.0.9
pin "motion", to: "https://cdn.jsdelivr.net/npm/motion@11.11.17/+esm"

