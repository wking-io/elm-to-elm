import React from 'react';

import { createMailbox } from '../lib/mailbox';

class ElmMailbox extends React.Component {
  node = React.createRef();

  componentDidMount() {
    const app = this.props.src.init({
      node: this.node.current,
      flags: {
        key: this.props.mailboxId,
      },
    });

    this.mailbox = createMailbox({ app, key: this.props.mailboxId });
  }

  componentWillUnmount() {
    this.mailbox.unsubscribe();
  }

  shouldComponentUpdate() {
    return false;
  }

  render() {
    return <div ref={this.node} />;
  }
}

// const ElmMailbox = React.memo(
//   ({ src, mailboxId }) => {
//     const elmRef = useRef(null);

//     useEffect(() => {
//       const app = src.init({
//         node: elmRef.current,
//         flags: {
//           key: mailboxId,
//         },
//       });

//       const mailbox = createMailbox({ app, key: mailboxId });

//       return function cleanup() {
//         mailbox.unsubscribe();
//       };
//     });

//     return <div ref={elmRef} />;
//   },
//   () => true
// );

export default ElmMailbox;
