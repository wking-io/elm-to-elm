export const event = 'cross-elm-message';
export const createMailbox = key => ({
  send(details) {
    return new CustomEvent(event, {
      bubbles: true,
      detail: Object.assign({ key }, details),
    });
  },
  subscribe(el, func) {
    el.addEventListener(event, func);
  },
});
