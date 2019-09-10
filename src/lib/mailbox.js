export const event = 'cross-elm-message';
export const createMailbox = ({ app, key }) => {
  const el = document.getElementById(key);
  const listener = ({ detail }) => {
    if (detail.key !== key) {
      console.log(detail); // eslint-disable-line
      app.ports.inbox.send(detail);
    }
  };

  window.addEventListener(event, listener);
  app.ports.outbox.subscribe(details => {
    console.log(details); // eslint-disable-line
    el.dispatchEvent(
      new CustomEvent(event, {
        bubbles: true,
        detail: Object.assign({ key }, details),
      })
    );
  });

  return {
    unsubscribe() {
      window.removeEventListener(event, listener);
    },
  };
};
