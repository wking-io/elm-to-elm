import '../css/base.css';
import '../css/frameTwo.css';
import { Elm } from '../elm/FrameTwo.elm';

Elm.FrameTwo.init({
  node: document.getElementById('frameTwo'),
  flags: {
    test: 'test',
  },
});
