// In assets/js/hooks.js (or wherever you define your hooks)
// Add this to your Hooks object and pass to LiveSocket

const SyncColorPicker = {
  mounted() {
    const swatch = this.el.querySelector("#badge-color-swatch");
    const text = this.el.querySelector("#badge-color-text");

    swatch.addEventListener("input", (e) => {
      text.value = e.target.value;
      // Trigger a change event so phx-change / validate picks it up
      text.dispatchEvent(new Event("change", { bubbles: true }));
    });
  },
};

export default SyncColorPicker;

// ─────────────────────────────────────────────────────────────────
// In assets/js/app.js, wire it up:
//
// import SyncColorPicker from "./hooks"   // or wherever you put it
//
// let Hooks = { SyncColorPicker }
//
// let liveSocket = new LiveSocket("/live", Socket, {
//   hooks: Hooks,
//   params: { _csrf_token: csrfToken }
// })
