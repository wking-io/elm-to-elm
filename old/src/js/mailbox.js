export const event = 'cross-elm-message';
export const createMailbox = key => {
  const el = document.getElementById(key);
  return {
    send(details) {
      console.log(details); // eslint-disable-line
      el.dispatchEvent(
        new CustomEvent(event, {
          bubbles: true,
          detail: Object.assign({ key }, details),
        })
      );
    },
    subscribe(func) {
      window.addEventListener(event, ({ detail }) => {
        if (detail.key != key) {
          console.log(detail); // eslint-disable-line
          func(detail);
        }
      });
    },
  };
};
