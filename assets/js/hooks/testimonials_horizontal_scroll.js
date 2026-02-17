// hooks/testimonials_horizontal_scroll.js
const TestimonialsHorizontalScroll = {
  mounted() {
    this.section = this.el;
    this.track = document.getElementById("testimonials-track");
    this.slides = this.track.querySelectorAll(".testimonial-slide");
    this.totalSlides = this.slides.length;

    this.ticking = false;

    // Calculate dimensions
    this.calculateDimensions();

    // Set up listeners
    this.handleScroll = () => {
      if (!this.ticking) {
        requestAnimationFrame(() => {
          this.updatePosition();
          this.ticking = false;
        });
        this.ticking = true;
      }
    };

    this.handleResize = () => {
      this.calculateDimensions();
      this.updatePosition();
    };

    window.addEventListener("scroll", this.handleScroll, { passive: true });
    window.addEventListener("resize", this.handleResize, { passive: true });

    // Initial update
    this.updatePosition();
  },

  calculateDimensions() {
    const slide = this.slides[0];
    const slideWidth = slide.offsetWidth;
    const gap = window.innerWidth >= 1024 ? 40 : 24;
    this.slideStep = slideWidth + gap;
    this.totalWidth = this.slideStep * (this.totalSlides - 1);
    this.viewportCenter = window.innerWidth / 2;
  },

  updatePosition() {
    const sectionRect = this.section.getBoundingClientRect();
    const sectionTop = sectionRect.top;
    const sectionHeight = this.section.offsetHeight - window.innerHeight;

    // Calculate progress (0 to 1)
    let progress = 0;
    if (sectionTop <= 0 && sectionTop >= -sectionHeight) {
      progress = Math.abs(sectionTop) / sectionHeight;
    } else if (sectionTop < -sectionHeight) {
      progress = 1;
    }

    // Move track horizontally
    const translateX = -progress * this.totalWidth;
    this.track.style.transform = `translateX(${translateX}px)`;

    // Update each slide based on its position relative to center
    this.slides.forEach((slide, index) => {
      const card = slide.querySelector(".testimonial-card");
      const slideRect = slide.getBoundingClientRect();
      const slideCenter = slideRect.left + slideRect.width / 2;

      // Distance from viewport center (normalized)
      const distanceFromCenter = Math.abs(slideCenter - this.viewportCenter);
      const maxDistance = this.slideStep * 1.5;
      const normalizedDistance = Math.min(distanceFromCenter / maxDistance, 1);

      // Calculate scale and opacity based on distance
      const scale = 1 - normalizedDistance * 0.1; // 1.0 to 0.9
      const opacity = 1 - normalizedDistance * 0.5; // 1.0 to 0.5
      const shadowOpacity = (1 - normalizedDistance) * 0.15;

      card.style.transform = `scale(${scale})`;
      card.style.opacity = opacity;
      card.style.boxShadow = `0 25px 50px -12px rgba(0, 0, 0, ${shadowOpacity})`;
    });
  },

  destroyed() {
    window.removeEventListener("scroll", this.handleScroll);
    window.removeEventListener("resize", this.handleResize);
  },
};

export default TestimonialsHorizontalScroll;
