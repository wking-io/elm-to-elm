import React from 'react';

import Link from '../components/link';
import Layout from '../components/layout';
import SEO from '../components/seo';
import { NewsletterInput } from '../components/newsletter';

const SurveyThankYou = () => (
  <Layout>
    <SEO title="Thank You" />
    <div
      className="max-w-3xl mx-auto px-8 flex flex-col min-h-screen md:items-center justify-center text-black md:text-center text-white
    "
    >
      <h2 className="text-4xl sm:text-5xl md:text-6xl font-display font-bold mb-4 leading-tight uppercase tracking-wide">
        Thank You For You Feedback. Get Notified When it launches!
      </h2>
      <p className="text-lg mb-12">
        I am so excited for the launch of Implementing Elm. This podcast is for
        everyone in the Elm community and I want your feedback along the way!
        Get updates on upcoming episodes, seasons, content and more by signing
        up for the launch list below.
      </p>
      <NewsletterInput id="newsletter-survey-follow-up" className="w-full" />
      <Link className="link" to="/">
        or head back to the homepage
      </Link>
    </div>
  </Layout>
);

export default SurveyThankYou;
