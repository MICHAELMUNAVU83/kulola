// hooks/hero_reveal.js
const HeroReveal = {
  mounted() {
    this.overlayLeft = document.getElementById("hero-overlay-left");
    this.overlayRight = document.getElementById("hero-overlay-right");
    this.heroImage = document.getElementById("hero-image");
    this.heroContent = this.el.querySelector(".hero-content");

    this.revealed = false;
    this.ticking = false;

    this.handleScroll = () => {
      if (!this.ticking) {
        requestAnimationFrame(() => {
          this.updateReveal();
          this.ticking = false;
        });
        this.ticking = true;
      }
    };

    window.addEventListener("scroll", this.handleScroll, { passive: true });

    // Initial check (in case page is already scrolled)
    this.updateReveal();
  },

  updateReveal() {
    const rect = this.el.getBoundingClientRect();
    const windowHeight = window.innerHeight;

    // Start reveal when hero enters viewport
    const revealStart = windowHeight * 0.8;
    const revealEnd = windowHeight * 0.2;

    // Calculate progress
    let progress = 0;
    if (rect.top < revealStart) {
      progress = Math.min(
        (revealStart - rect.top) / (revealStart - revealEnd),
        1,
      );
    }

    // Apply easing
    const easedProgress = this.easeOutQuart(progress);

    // Curtain effect - slides out to sides
    const leftTranslate = -easedProgress * 100;
    const rightTranslate = easedProgress * 100;

    this.overlayLeft.style.transform = `translateX(${leftTranslate}%)`;
    this.overlayRight.style.transform = `translateX(${rightTranslate}%)`;

    // Image reveal with zoom
    if (progress > 0.3) {
      const imageProgress = Math.min((progress - 0.3) / 0.7, 1);
      const easedImageProgress = this.easeOutCubic(imageProgress);
      const scale = 1.1 - easedImageProgress * 0.1;

      this.heroImage.style.opacity = easedImageProgress;
      this.heroImage.style.transform = `scale(${scale})`;
    }

    // Content fade in
    if (progress > 0.5) {
      this.heroContent.style.opacity = "1";
      this.heroContent.style.transform = "translateY(0)";
    } else {
      this.heroContent.style.opacity = "0";
      this.heroContent.style.transform = "translateY(20px)";
    }
  },

  easeOutQuart(t) {
    return 1 - Math.pow(1 - t, 4);
  },

  easeOutCubic(t) {
    return 1 - Math.pow(1 - t, 3);
  },

  destroyed() {
    window.removeEventListener("scroll", this.handleScroll);
  },
};

export default HeroReveal;
