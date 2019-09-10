import '../css/base.css';
import '../css/frameTwo.css';
import { Elm } from '../elm/FrameTwo.elm';
import { createMailbox } from './mailbox';

const key = 'frameTwo';
const app = Elm.FrameTwo.init({
  node: document.getElementById(key),
  flags: {
    key,
  },
});

const mailbox = createMailbox(key);
mailbox.subscribe(app.ports.inbox.send);
app.ports.outbox.subscribe(mailbox.send);
