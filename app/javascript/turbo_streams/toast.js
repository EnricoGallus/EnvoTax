import Toastify from "toastify-js"

window.Turbo.StreamActions.toast = function() {
    const text = this.getAttribute("text")
    const className = `bg-${this.getAttribute("type")}`
    const duration = Number(this.getAttribute("duration"))
    const gravity = this.getAttribute("gravity")
    const position = this.getAttribute("position")

    /*TODO: styling of toasts not done yet*/
    Toastify({
        text: text,
        duration: duration,
        gravity: gravity,
        position: position,
        className: className,
        stopOnFocus: true,
    }).showToast()
}