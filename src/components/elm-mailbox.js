import React, { useRef, useEffect } from 'react';

import { createMailbox } from '../lib/mailbox';

const ElmMailbox = React.memo(
  ({ src, mailboxId }) => {
    const elmRef = useRef(null);

    useEffect(() => {
      const app = src.init({
        node: elmRef.current,
        flags: {
          key: mailboxId,
        },
      });

      const mailbox = createMailbox({ app, key: mailboxId });

      return function cleanup() {
        mailbox.unsubscribe();
      };
    });

    return <div ref={elmRef} />;
  },
  () => true
);

export default ElmMailbox;
