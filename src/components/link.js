import React from 'react';
import { Link as GatsbyLink } from 'gatsby';

const internal = to => /^\/(?!\/)/.test(to);
const Link = ({ children, to, activeClassName, partiallyActive, ...props }) =>
  internal(to) ? (
    <GatsbyLink
      to={to}
      activeClassName={activeClassName}
      partiallyActive={partiallyActive}
      {...props}
    >
      {children}
    </GatsbyLink>
  ) : (
    <a href={to} {...props}>
      {children}
    </a>
  );

export default Link;
