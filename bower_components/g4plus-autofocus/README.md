About
=====

This repository hosts autofocus directive. This directive works in a similar
way to the HTML5 autofocus directive with the following differences:

 1. Works on browsers that we need to support (IE 8, 9)
 2. Solves the problem with caret moving to end of text (IE 8, ... and older browsers)
 3. Works not just on page load. By watching bootstrap modal window open and
    close the focus is given back to the element found bellow the modal.

Template
========

Include the directive in your jade list template as:

    input(
      g4-autofocus
    )

If you want to regain focus once the bootstrap modal window closes:

    input(
      g4-autofocus="regain-focus"
    )
