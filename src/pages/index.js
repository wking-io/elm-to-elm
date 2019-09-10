// Dependencies
import React from 'react';

import countAppOne from '../elm/CountOne.elm';
import countAppTwo from '../elm/CountTwo.elm';

// Components
import Layout from '../components/layout';
import SEO from '../components/seo';
import ElmMailbox from '../components/elm-mailbox';

const IndexPage = () => (
  <Layout>
    <SEO />
    <section className="flex items-center justify-center min-h-screen w-full">
      <ElmMailbox src={countAppOne.Elm.CountOne} mailboxId="count-one" />
      <ElmMailbox src={countAppTwo.Elm.CountTwo} mailboxId="count-two" />
    </section>
  </Layout>
);

export default IndexPage;
