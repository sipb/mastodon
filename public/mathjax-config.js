MathJax.Hub.Config({
  skipStartupTypeset: true,
  tex2jax: {
    skipTags: ["script","noscript","style","textarea","pre","code","a"],
    processRefs: false,
    processEnvironments: false
  },
  TeX: {
    MAXMACROS: 0,
    MAXBUFFER: 250
  },
  Safe: {
    allow: {
      URLs: "none",
      classes: "none",
      cssIDs: "none",
      styles: "none",
      require: "none",
      fontsize: "safe"
    }
  }
});

MathJax.Ajax.loadComplete("/mathjax-config.js");
