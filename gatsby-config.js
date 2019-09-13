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
    image: '/images/social.jpg',
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
        icon: 'src/images/social.jpg', // This path is relative to the root of the site.
      },
    },
    {
      resolve: `gatsby-plugin-prefetch-google-fonts`,
      options: {
        fonts: [
          {
            family: `Fira Mono`,
            subsets: [`latin`],
            variants: [`400`],
            formats: [`woff`, `woff2`],
          },
          {
            family: `Fira Sans`,
            subsets: [`latin`],
            variants: [`400`, `400i`, `500`, `500i`, `700`, `700i`],
            formats: [`woff`, `woff2`],
          },
        ],
      },
    },
    'gatsby-plugin-postcss',
    'gatsby-plugin-elm',
    'gatsby-plugin-offline',
  ],
};
