/* overwrite label renderer */
sigma.utils.pkg('sigma.canvas.hovers');
sigma.canvas.hovers.def = function(node, context, settings) {
  var prefix = settings('prefix') || '';
    
  var x,
      y,
      w,
      h,
      e,
      nodeX,
      textX,
      nodeLabel,
      r = 10,
      arrowSize = 10,
      fontStyle = settings('hoverFontStyle') || settings('fontStyle'),
      prefix = settings('prefix') || '',
      size = node[prefix + 'size'],
      fontSize = (settings('labelSize') === 'fixed') ?
        settings('defaultLabelSize') :
        settings('labelSizeRatio') * size;

  // Label background:
  context.font = (fontStyle ? fontStyle + ' ' : '') +
    fontSize + 'px ' + (settings('hoverFont') || settings('font'));

  context.beginPath();
  context.fillStyle = settings('labelHoverBGColor') === 'node' ?
    (node.color || settings('defaultNodeColor')) :
    settings('defaultHoverLabelBGColor');

  if (node.label && settings('labelHoverShadow')) {
    context.shadowOffsetX = 0;
    context.shadowOffsetY = 0;
    context.shadowBlur = 8;
    context.shadowColor = settings('labelHoverShadowColor');
  }

  nodeLabel = node.label;
  if (nodeLabel.length > 30) nodeLabel = nodeLabel.substring(0,30)+"...";

  if (node.label && typeof node.label === 'string') {
    e = Math.round(fontSize / 2 + 16);
    x = Math.round(node[prefix + 'x'] + size + arrowSize);
    y = Math.round(node[prefix + 'y'] - e);
    w = Math.round(
      context.measureText(nodeLabel).width + e
    );
    h = e*2;
    nodeX = node['renderer1:x'];  // graph 2_1
    if (nodeX === undefined) nodeX = node['renderer2:x']; //graph 2_4
    if (nodeX === undefined) nodeX = node['renderer3:x']; //graph 3_4

    if (nodeX < context.canvas.width/2+30) {
      //tooltip to right
      context.beginPath();
      context.moveTo(x + r, y);
      context.lineTo(x + w - r, y);
      context.quadraticCurveTo(x + w, y, x + w, y + r);
      context.lineTo(x + w, y + h - r);
      context.quadraticCurveTo(x + w, y + h, x + w - r, y + h);
      context.lineTo(x + r, y + h);
      context.quadraticCurveTo(x, y + h, x, y + h - r);
      context.lineTo(x, y + e + arrowSize);
      context.lineTo(x - arrowSize, y + e);
      context.lineTo(x, y + e - arrowSize);
      context.lineTo(x, y + r);
      context.quadraticCurveTo(x, y, x + r, y);
      context.closePath();

      context.closePath();
      context.fill();

      textX = Math.round(node[prefix + 'x'] + size + arrowSize + fontSize / 2 + 3);
    }
    else {
      //tooltip to left
      x = Math.round(node[prefix + 'x'] - size - w - arrowSize);
      context.beginPath();
      context.moveTo(x + r, y);
      context.lineTo(x + w - r, y);
      context.quadraticCurveTo(x + w, y, x + w, y + r);
      context.lineTo(x + w, y + e + arrowSize);
      context.lineTo(x + w + arrowSize, y + e);
      context.lineTo(x + w, y + e - arrowSize);
      context.lineTo(x + w, y + h - r);
      context.quadraticCurveTo(x + w, y + h, x + w - r, y + h);
      context.lineTo(x + r, y + h);
      context.quadraticCurveTo(x, y + h, x, y + h - r);
      context.lineTo(x, y + r);
      context.quadraticCurveTo(x, y, x + r, y);
      context.closePath();

      context.closePath();
      context.fill();

      textX = Math.round(node[prefix + 'x'] - w - size + 3);
    }
    context.shadowOffsetX = 0;
    context.shadowOffsetY = 0;
    context.shadowBlur = 0;
  }

  // Display the label:
  if (node.label && typeof node.label === 'string') {
    context.fillStyle = (settings('labelHoverColor') === 'node') ?
      (node.color || settings('defaultNodeColor')) :
      settings('defaultLabelHoverColor');

    context.fillText(
      nodeLabel,
      textX,
      Math.round(node[prefix + 'y'] + fontSize / 3)
    );
  }
};