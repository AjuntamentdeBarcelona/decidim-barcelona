(function () {
  var iframe = document.createElement('iframe');
  var scripts = document.getElementsByTagName('script');
  var me = null;

  if (document.currentScript) {
    me = document.currentScript;
  } else {
    me = scripts[scripts.length - 1];
  }

  iframe.src = "https://www.decidim.barcelona/consells/horta.html";
  iframe.width = "100%";
  iframe.frameBorder = "0";
  iframe.scrolling = "no";
  iframe.style.visibility = 'hidden';
  iframe.style.height = "10px";
  iframe.onload = function () {
    iframe.contentWindow.postMessage({ type: "GET_HEIGHT" }, "*");
  }

  me.insertAdjacentElement('afterend', iframe);

  window.addEventListener("message", function (event) {
    var height = event.data.height;

    if (event.data.type === "SET_HEIGHT") {
      iframe.style.height = height + "px";
      iframe.style.visibility = 'visible';
    }
  });
}());
