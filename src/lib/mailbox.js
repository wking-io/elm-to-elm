export const event = 'cross-elm-message';
export const createMailbox = ({ app, key }) => {
  const el = document.getElementById(key);
  const listener = ({ detail }) => {
    if (detail.key !== key) {
      app.ports.inbox.send(detail);
    }
  };

  window.addEventListener(event, listener);
  app.ports.outbox.subscribe(details => {
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
