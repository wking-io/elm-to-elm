// Dependencies
import React from 'react';
import Helmet from 'react-helmet';

const Layout = ({ children }) => (
  <>
    <Helmet>
      <link rel="stylesheet" href="https://use.typekit.net/ctk8kir.css" />
    </Helmet>
    {children}
    <footer className="w-11/12 md:w-5/6 max-w-5xl mx-auto px-4 md:px-12 pb-3 text-white text-xs">
      <div className="h-px bg-white mb-3"></div>
      <p>&copy; Implementing Elm 2019</p>
    </footer>
  </>
);

export default Layout;
