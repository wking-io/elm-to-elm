require('dotenv').config({
  path: `.env.${process.env.NODE_ENV}`,
});

module.exports = {
  siteMetadata: {
    title:
      'A playground for communication between multiple Elm apps on the same page | Elm ⇔ Elm',
    titleTemplate: '%s | Implementing Elm',
    description:
      "A playground for explorations into communication between multiple Elm apps on the same page. I think this is especially interesting for software that will be embedded as a 3rd party on a someone else's website.",
    url: 'https://www.elm-to-elm.com',
    image: '/images/favicon.png',
    twitterUsername: '@wking__',
  },
  plugins: [
    'gatsby-plugin-react-helmet',
    'gatsby-transformer-json',
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'src',
        path: `${__dirname}/src`,
      },
    },
    'gatsby-transformer-sharp',
    'gatsby-plugin-sharp',
    {
      resolve: 'gatsby-plugin-manifest',
      options: {
        name: 'Implementing Elm',
        short_name: 'IH',
        start_url: '/',
        background_color: '#0b1319',
        theme_color: '#0b1319',
        display: 'minimal-ui',
        icon: 'src/images/favicon.png', // This path is relative to the root of the site.
      },
    },
    'gatsby-plugin-postcss',
    'gatsby-plugin-offline',
  ],
};
