import '../css/base.css';
import '../css/frameOne.css';
import { Elm } from '../elm/FrameOne.elm';

import { createMailbox } from './mailbox';

const key = 'frameOne';

const app = Elm.FrameOne.init({
  node: document.getElementById(key),
  flags: {
    key,
  },
});

const mailbox = createMailbox(key);
mailbox.subscribe(app.ports.inbox.send);
app.ports.outbox.subscribe(mailbox.send);
