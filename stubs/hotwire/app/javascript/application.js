import "@hotwired/turbo-rails"

import Alpine from "alpinejs"
window.Alpine = Alpine

document.addEventListener("DOMContentLoaded", function(event) {
  window.Alpine.start()
})
