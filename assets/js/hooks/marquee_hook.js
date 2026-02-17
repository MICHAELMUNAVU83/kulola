/**
 * MarqueeHook: seamless infinite horizontal scroll with no white space.
 * Clones the first segment until the track is at least 2x viewport width,
 * then animates by exactly one segment width for a perfect loop.
 */
const MarqueeHook = {
  mounted() {
    this.track = this.el.querySelector("[data-marquee-track]");
    this.segment = this.track?.querySelector("[data-marquee-segment]");
    if (!this.track || !this.segment) return;

    this.fillAndAnimate();
    window.addEventListener("resize", this.resizeHandler = () => this.fillAndAnimate());
  },

  destroyed() {
    window.removeEventListener("resize", this.resizeHandler);
  },

  fillAndAnimate() {
    const viewportWidth = document.documentElement.clientWidth;
    const minTrackWidth = viewportWidth * 2;

    // Remove any clones we added (keep only original segments from the server)
    const segments = this.track.querySelectorAll("[data-marquee-segment]");
    segments.forEach((seg, i) => {
      if (seg.hasAttribute("data-marquee-clone")) seg.remove();
    });

    // Clone the first segment until track is wide enough for a seamless loop
    let segmentWidth = this.segment.offsetWidth;
    while (this.track.offsetWidth < minTrackWidth) {
      const clone = this.segment.cloneNode(true);
      clone.setAttribute("data-marquee-clone", "");
      this.track.appendChild(clone);
    }

    const totalSegments = this.track.querySelectorAll("[data-marquee-segment]").length;
    const segmentWidthPx = this.segment.offsetWidth;

    // Use CSS custom property so keyframes translate by exactly one segment
    this.track.style.setProperty("--marquee-segment-width", `${segmentWidthPx}px`);
    this.track.style.setProperty("--marquee-duration", "25s");

    this.injectKeyframes();
  },

  injectKeyframes() {
    const id = "marquee-keyframes-" + (this.el.id || "banner");
    let style = document.getElementById(id);
    if (!style) {
      style = document.createElement("style");
      style.id = id;
      document.head.appendChild(style);
    }
    style.textContent = `
      @keyframes marquee-loop {
        0%   { transform: translateX(0); }
        100% { transform: translateX(calc(-1 * var(--marquee-segment-width, 50%))); }
      }
      [data-marquee-track].animate-marquee {
        animation: marquee-loop var(--marquee-duration) linear infinite;
      }
    `;
  }
};

export default MarqueeHook;
