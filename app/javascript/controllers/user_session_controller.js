import { Controller } from "stimulus"

export default class extends Controller {
  reload() {
    Turbolinks.visit(location.href)
  }
}
