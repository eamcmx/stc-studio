// Packs the app into one file, dist/stc-studio.html: app/index.html with every script inlined.
//   node tools/make_examples.js && node tools/build.js
'use strict';
const fs = require('fs');
const path = require('path');
const ROOT = path.join(__dirname, '..');
let html = fs.readFileSync(path.join(ROOT, 'app/index.html'), 'utf8');
const used = [];
html = html.replace(/<script src="([^"]+)"><\/script>/g, (m, src) => {
  const file = path.join(ROOT, 'app', src);
  const code = fs.readFileSync(file, 'utf8').replace(/<\/script/gi, '<\\/script');
  used.push(path.relative(ROOT, file).replace(/\\/g, '/') + ' (' + (code.length / 1024).toFixed(0) + ' KB)');
  return '<script>\n/* ---- ' + path.relative(ROOT, file).replace(/\\/g, '/') + ' ---- */\n' + code + '\n</script>';
});
if (/<script src=/.test(html)) throw new Error('a script was not inlined');
fs.mkdirSync(path.join(ROOT, 'dist'), { recursive: true });
fs.writeFileSync(path.join(ROOT, 'dist/stc-studio.html'), html);
console.log('dist/stc-studio.html: ' + (html.length / 1024).toFixed(0) + ' KB from\n  ' + used.join('\n  '));
