import React from 'react';
import { useStaticQuery, graphql } from 'gatsby';
import Img from 'gatsby-image';

const Image = ({ img, ...props }) => {
  const data = useStaticQuery(graphql`
    query {
      favicon: file(relativePath: { eq: "images/favicon.png" }) {
        childImageSharp {
          fluid(maxWidth: 800) {
            ...GatsbyImageSharpFluid
          }
        }
      }
    }
  `);

  return <Img fluid={data[img].childImageSharp.fluid} {...props} />;
};

export default Image;
