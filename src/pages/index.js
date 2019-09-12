// Dependencies
import React from 'react';

import countAppOne from '../elm/CountOne.elm';
import countAppTwo from '../elm/CountTwo.elm';

// Components
import Layout from '../components/layout';
import SEO from '../components/seo';
import ElmMailbox from '../components/elm-mailbox';

const CountExample = () => (
  <section className="flex flex-col md:flex-row items-center justify-center min-h-screen w-full px-4">
    <div className="text-center md:w-1/2 my-4 md:my-0 md:mx-4 p-8 border-2 border-black rounded count-box">
      <ElmMailbox src={countAppOne.Elm.CountOne} mailboxId="count-one" />
    </div>
    <div className="text-center md:w-1/2 my-4 md:my-0 md:mx-4 p-8 border-2 border-black rounded count-box">
      <ElmMailbox src={countAppTwo.Elm.CountTwo} mailboxId="count-two" />
    </div>
  </section>
);

const IndexPage = () => (
  <Layout>
    <SEO />
    <CountExample />
  </Layout>
);

export default IndexPage;
