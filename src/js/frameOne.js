import '../css/base.css';
import '../css/frameOne.css';
import { Elm } from '../elm/FrameOne.elm';

Elm.FrameOne.init({
  node: document.getElementById('frameOne'),
  flags: {
    test: 'test',
  },
});
