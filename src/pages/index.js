// Dependencies
import React from 'react';

import countAppOne from '../elm/CountOne.elm';
import countAppTwo from '../elm/CountTwo.elm';
import gameBoardOne from '../elm/GameOne.elm';
import gameBoardTwo from '../elm/GameTwo.elm';
import gameBoardThree from '../elm/GameThree.elm';
import gameBoardFour from '../elm/GameFour.elm';

// Components
import Layout from '../components/layout';
import SEO from '../components/seo';
import Link from '../components/link';
import ElmMailbox from '../components/elm-mailbox';
import { LogoIcon } from '../components/icons';

const CountExample = () => (
  <section className="mb-20">
    <div className="px-4 md:w-5/6 max-w-4xl md:mx-auto">
      <h2 className="text-2xl font-bold">Count Example:</h2>
      <p className="mb-8">
        Uses custom browser events to send messages between two separate Elm
        apps embedded on the same page. You can checkout the code for this
        example in this{' '}
        <Link
          className="underline hover:no-underline"
          to="https://github.com/wking-io/elm-to-elm"
        >
          Github Repo
        </Link>
      </p>
      <div className="flex flex-col md:flex-row items-center justify-center w-full">
        <div className="text-center md:w-1/2 my-4 md:my-0 md:mr-4 p-8 border-2 border-black rounded count-box">
          <ElmMailbox src={countAppOne.Elm.CountOne} mailboxId="count-one" />
        </div>
        <div className="text-center md:w-1/2 my-4 md:my-0 md:ml-4 p-8 border-2 border-black rounded count-box">
          <ElmMailbox src={countAppTwo.Elm.CountTwo} mailboxId="count-two" />
        </div>
      </div>
    </div>
  </section>
);

const GameExample = () => (
  <section className="mb-20">
    <div className="px-4 md:w-5/6 max-w-4xl md:mx-auto">
      <h2 className="text-2xl font-bold">Game Example:</h2>
      <p className="mb-8">
        Uses custom browser events to send messages between two separate Elm
        apps embedded on the same page. You can checkout the code for this
        example in this{' '}
        <Link
          className="underline hover:no-underline"
          to="https://github.com/wking-io/elm-to-elm"
        >
          Github Repo
        </Link>
      </p>
      <div className="flex flex-col md:flex-row items-center justify-center w-full">
        <div className="flex flex-wrap justify-center items-center max-w-xl">
          <div className="mb-8 mr-4">
            <ElmMailbox src={gameBoardOne.Elm.GameOne} mailboxId="game-one" />
          </div>
          <div className="mb-8 ml-4">
            <ElmMailbox src={gameBoardTwo.Elm.GameTwo} mailboxId="game-two" />
          </div>
          <div className="mb-8 mr-4">
            <ElmMailbox
              src={gameBoardThree.Elm.GameThree}
              mailboxId="game-three"
            />
          </div>
          <div className="mb-8 ml-4">
            <ElmMailbox
              src={gameBoardFour.Elm.GameFour}
              mailboxId="game-four"
            />
          </div>
        </div>
      </div>
    </div>
  </section>
);

const IndexPage = () => (
  <Layout>
    <SEO />
    <div className="flex justify-center items-center py-24">
      <div className="h-32">
        <LogoIcon />
      </div>
      <h1 className="font-bold text-5xl ml-6">elm-to-elm</h1>
    </div>
    <CountExample />
    <GameExample />
  </Layout>
);

export default IndexPage;
