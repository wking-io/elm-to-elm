import React, { useState, useRef } from 'react';
import VisuallyHidden from '@reach/visually-hidden';

const Survey = () => {
  const [showOther, setShowOther] = useState(false);
  const [otherField, setOtherField] = useState('');
  const [selection, setSelection] = useState('');
  const otherFieldRef = useRef(null);

  return (
    <form
      name="next-season-01"
      method="POST"
      action="/surveys/next-season-thank-you"
      netlify-honeypot="bot-field"
      data-netlify="true"
      className="w-full"
      id="survey-next-season-01"
    >
      <input type="hidden" name="form-name" value="next-season-01" />
      <input type="hidden" name="selection" value={selection} />
      <VisuallyHidden>
        <label>
          Don’t fill this out if you're human: <input name="bot-field" />
        </label>
      </VisuallyHidden>
      <fieldset className="">
        <div className="ui-checkbox mb-2 flex">
          <input
            className="ui-checkbox__input"
            type="radio"
            id="dnd"
            value="dnd"
            name="next-season-choice"
            onChange={() => {
              setShowOther(false);
              setSelection('dnd');
            }}
          />
          <label
            className="ui-checkbox__label w-full border border-white"
            htmlFor="dnd"
          >
            <span className="block relative z-10 py-3 px-6 text-sm">
              Drag-n-Drop
            </span>
          </label>
        </div>
        <div className="ui-checkbox mb-2 flex">
          <input
            className="ui-checkbox__input"
            type="radio"
            id="draw"
            value="draw"
            name="next-season-choice"
            onChange={() => {
              setShowOther(false);
              setSelection('draw');
            }}
          />
          <label
            className="ui-checkbox__label w-full border border-white"
            htmlFor="draw"
          >
            <span className="block relative z-10 py-3 px-6 text-sm">
              Drawing Interfaces
            </span>
          </label>
        </div>
        <div className="ui-checkbox mb-2 flex">
          <input
            className="ui-checkbox__input"
            type="radio"
            id="metrics"
            value="metrics"
            name="next-season-choice"
            onChange={() => {
              setShowOther(false);
              setSelection('metrics');
            }}
          />
          <label
            className="ui-checkbox__label w-full border border-white"
            htmlFor="metrics"
          >
            <span className="block relative z-10 py-3 px-6 text-sm">
              Metrics / Charts
            </span>
          </label>
        </div>
        <div className="ui-checkbox flex">
          <input
            className="ui-checkbox__input"
            type="radio"
            id="other"
            value="other"
            name="next-season-choice"
            onChange={() => {
              setShowOther(true);
              otherFieldRef.current.focus();
              setSelection(otherField);
            }}
          />
          <label
            className="ui-checkbox__label w-full border border-white"
            htmlFor="other"
          >
            <span className="block relative z-10 py-3 px-6 text-sm">Other</span>
          </label>
        </div>
      </fieldset>
      <div>
        <input
          className={`bg-transparent text-white border border-white py-3 px-6 w-full text-sm ${
            showOther ? '' : 'h-0 overflow-hidden opacity-0'
          }`}
          type="text"
          name="other-value"
          placeholder="Enter other topic here"
          ref={otherFieldRef}
          value={otherField}
          onChange={({ target }) => {
            setOtherField(target.value);
            setSelection(`Other: ${target.value}`);
          }}
        />
      </div>
      <input
        className={`btn btn--primary block mt-8 w-full rounded-none ${
          selection.length > 0 ? 'cursor-pointer' : 'cursor-not-allowed'
        }`}
        type="submit"
        value="Submit Survey"
        disabled={selection.length === 0}
      />
    </form>
  );
};

export default Survey;
