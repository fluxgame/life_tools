import flatpickr from "flatpickr"

let Hooks = {}

Hooks.DatePicker = {
  mounted() {
    flatpickr(this.el, {
      enableTime: false,
      dateFormat: "Y-m-d"
    });
  },
}

export default Hooks;
