// hooks/countdown_timer.js
const CountdownTimer = {
  mounted() {
    // Set end date 9 days, 19 hours, 23 minutes from now
    this.endDate = new Date();
    this.endDate.setDate(this.endDate.getDate() + 9);
    this.endDate.setHours(this.endDate.getHours() + 19);
    this.endDate.setMinutes(this.endDate.getMinutes() + 23);

    this.daysEl = document.getElementById("countdown-days");
    this.hoursEl = document.getElementById("countdown-hours");
    this.minutesEl = document.getElementById("countdown-minutes");
    this.secondsEl = document.getElementById("countdown-seconds");

    this.updateCountdown();
    this.interval = setInterval(() => this.updateCountdown(), 1000);
  },

  updateCountdown() {
    const now = new Date();
    const diff = this.endDate - now;

    if (diff <= 0) {
      clearInterval(this.interval);
      this.daysEl.textContent = "0";
      this.hoursEl.textContent = "00";
      this.minutesEl.textContent = "00";
      this.secondsEl.textContent = "00";
      return;
    }

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    this.daysEl.textContent = days;
    this.hoursEl.textContent = hours.toString().padStart(2, "0");
    this.minutesEl.textContent = minutes.toString().padStart(2, "0");
    this.secondsEl.textContent = seconds.toString().padStart(2, "0");
  },

  destroyed() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  },
};

export default CountdownTimer;
