import '../css/base.css';
import '../css/frameOne.css';
import { Elm } from '../elm/FrameOne.elm';

import { createMailbox } from './mailbox';

const frame = document.getElementById('frameOne');
const mailbox = createMailbox('frameOne');

const app = Elm.FrameOne.init({
  node: frame,
  flags: {
    test: 'test',
  },
});

mailbox.subscribe(app.ports.inbox.send);
app.ports.outbox.subscribe(mailbox.send);
