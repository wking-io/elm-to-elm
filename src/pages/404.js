import React from 'react';

import Link from '../components/link';
import Layout from '../components/layout';
import SEO from '../components/seo';

const NotFoundPage = () => (
  <Layout>
    <SEO title="404: Not found" />
    <div
      className="max-w-3xl mx-auto px-8 flex flex-col min-h-screen md:items-center justify-center text-black md:text-center text-white
    "
    >
      <h2 className="text-4xl sm:text-5xl md:text-6xl font-display font-bold mb-4 leading-tight uppercase tracking-wide">
        Not Found!
      </h2>
      <p className="text-lg mb-8">
        This page doesn't exist, but you can get back to the site using the link
        below.
      </p>
      <Link className="btn btn--primary" to="/">
        Back to homepage
      </Link>
    </div>
  </Layout>
);

export default NotFoundPage;
