// Dependencies
import React from 'react';
import VisuallyHidden from '@reach/visually-hidden';

// Components
import Layout from '../components/layout';
import { NewsletterInput } from '../components/newsletter';
import {
  GlitchBase,
  GlitchOne,
  GlitchTwo,
  GlitchThree,
  GlitchFour,
} from '../components/glitch';
import Survey from '../components/survey';
import SEO from '../components/seo';

const IndexPage = () => (
  <Layout>
    <SEO />
    <section className="flex flex-col items-center justify-center min-h-screen bg-black">
      <div className="w-11/12 md:w-5/6 max-w-5xl mx-auto">
        <VisuallyHidden>
          <h1>Implementing Elm</h1>
        </VisuallyHidden>
        <div aria-hidden>
          <div className="relative mb-10">
            <GlitchBase className="glitch-base" />
            <GlitchOne className="glitch-01 absolute w-full inset-0 opacity-0" />
            <GlitchTwo className="glitch-02 absolute w-full inset-0 opacity-0" />
            <GlitchThree className="glitch-03 absolute w-full inset-0 opacity-0" />
            <GlitchFour className="glitch-04 absolute w-full inset-0 opacity-0" />
          </div>
          <NewsletterInput
            id="newsletter-home-hero"
            className="w-full px-4 md:px-12 md:mx-auto"
          />
        </div>
      </div>
    </section>
    <section className="w-11/12 md:w-5/6 max-w-5xl mx-auto px-4 md:px-12 pt-6 text-white">
      <div className="h-px bg-white mb-16"></div>
      <p className="mb-12 leading-relaxed lg:text-lg">
        Implementing Elm will dive deep into specific problems to help the Elm
        community get better together by listening to real implementation
        stories from the Elm community. Although we have a strong and helpful
        community (one of the best in development in my opinion) Elm is young.
        The depth of resources that share a team or community members
        perspective on implementing Elm features in production can be better and
        I want to help. Implementing Elm will be a platform that shares real
        implementation stories from the community. Both through audio, text, and
        who know what else we can do.
      </p>
    </section>
    <section className="w-11/12 md:w-5/6 max-w-5xl mx-auto px-4 md:px-12 pt-6 pb-16 text-white">
      <div className="h-px bg-white mb-16"></div>
      <div className="flex flex-col lg:flex-row">
        <div className="lg:max-w-sm lg:mr-16 mb-8">
          <h2 className="text-5xl font-display uppercase tracking-wide leading-tight mb-4">
            Tell Me What You Want To Hear
          </h2>
          <p>
            The first season is already locked down for exploring text
            editing/parsing implementation stories, but get your vote in for the
            upcoming seasons.
          </p>
        </div>
        <Survey />
      </div>
    </section>
  </Layout>
);

export default IndexPage;
