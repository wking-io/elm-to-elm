// Dependencies
import React, { useState } from 'react';
import VisuallyHidden from '@reach/visually-hidden';
import { validate } from 'email-validator';

const VALID = 'valid';
const EMAIL_ERROR = 'error';
const EMAIL_EMPTY = 'empty';

export const NewsletterInput = ({ className, ...props }) => {
  const [valid, setValid] = useState(EMAIL_EMPTY);
  const [email, setEmail] = useState('');
  const validateForm = () => {
    if (email.length >= 0) {
      if (validate(email)) {
        setValid(VALID);
      } else {
        setValid(EMAIL_ERROR);
      }
    } else {
      setValid(EMAIL_EMPTY);
    }
  };

  const getInputClass = validState => {
    if (validState === VALID) {
      return 'cursor-pointer';
    }
    return 'cursor-not-allowed';
  };

  const isDisabled = validState => {
    if (validState === VALID) {
      return false;
    } else if (validState === EMAIL_ERROR) {
      return true;
    } else if (validState === EMAIL_EMPTY) {
      return true;
    }
    return true;
  };

  const showError = validState => {
    if (validState === VALID) {
      return false;
    } else if (validState === EMAIL_ERROR) {
      return true;
    } else if (validState === EMAIL_EMPTY) {
      return false;
    }
    return false;
  };

  return (
    <form
      className={`newsletter ${className}`}
      name="newsletter-signups"
      method="POST"
      action="/newsletter-thank-you"
      netlify-honeypot="bot-field"
      data-netlify="true"
      {...props}
    >
      <div className={`newsletter-input bg-black relative z-20`}>
        <div className="absolute bg-black border border-white z-10 w-full inset-0 h-full"></div>
        <div className="newsletter-input-glitch">
          <span></span>
          <span></span>
          <span></span>
        </div>
        <div className="newsletter-input-glitch-02">
          <span></span>
          <span></span>
          <span></span>
        </div>
        <div className="relative w-full z-30 p-2 flex flex-col md:flex-row justify-between">
          <input type="hidden" name="form-name" value="newsletter-signups" />
          <VisuallyHidden>
            <label>
              Don’t fill this out if you're human: <input name="bot-field" />
            </label>
          </VisuallyHidden>
          <input
            className="pt-2 text-center md:text-left pb-4 md:p-2 flex-1 text-white bg-transparent"
            type="text"
            placeholder="Enter email address..."
            name="Email Address"
            onBlur={validateForm}
            onChange={({ target }) => setEmail(target.value)}
          />
          <input
            className={`btn w-auto px-4 capitalize rounded-none ${getInputClass(
              valid
            )}`}
            type="submit"
            value="Join The Launch List"
            disabled={isDisabled(valid)}
            onMouseEnter={validateForm}
          />
        </div>
      </div>
      <div
        className={`newsletter-error${
          showError(valid) ? ' newsletter-error--visible' : ''
        } bg-glitch-red text-white relative z-10`}
      >
        <p className="py-3 px-4">Your email is invalid. Please try again.</p>
      </div>
    </form>
  );
};
