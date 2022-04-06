import "src/vendor/jquery.browser";
import "src/vendor/jquery-iframe-auto-height";

$(() => {
  $("iframe.autoheight").iframeAutoHeight({
    heightOffset: 150
  });
})
