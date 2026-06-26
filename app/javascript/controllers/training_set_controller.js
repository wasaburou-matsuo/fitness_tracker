import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.index = this.containerTarget.querySelectorAll(".set-row").length
  }

  addSet() {
    const setNumber = this.containerTarget.querySelectorAll(".set-row").length + 1
    const html = `
      <div class="set-row">
        <span>セット${setNumber}</span>
        <input type="hidden" name="training_session[training_sets_attributes][${this.index}][set_number]" value="${setNumber}" data-set-number>
        <input type="number" name="training_session[training_sets_attributes][${this.index}][weight]" step="0.5" min="0" placeholder="重量 (kg)" required>
        <input type="number" name="training_session[training_sets_attributes][${this.index}][reps]" min="1" placeholder="回数" required>
        <button type="button" data-action="click->training-set#removeSet">削除</button>
      </div>
    `
    this.containerTarget.insertAdjacentHTML("beforeend", html)
    this.index++
  }

  removeSet(event) {
    const rows = this.containerTarget.querySelectorAll(".set-row")
    if (rows.length > 1) {
      event.target.closest(".set-row").remove()
      this.renumber()
    }
  }

  renumber() {
    this.containerTarget.querySelectorAll(".set-row").forEach((row, i) => {
      row.querySelector("span").textContent = `セット${i + 1}`
      row.querySelector("[data-set-number]").value = i + 1
    })
  }
}
