// A small Chrome DevTools Protocol client for testing the STC Studio pages in a separate Chrome (its own
// throwaway profile, started with --remote-debugging-port). Used where a test needs Chrome's serial-port chooser
// answered: DeviceAccess.selectPrompt picks the CH340 for the page under test.
//   node tools/cdp.js <port> <url-part> <command> [args]
//     eval '<js>'          run JS in the page (with a user gesture), print the result
//     pick                 click the page's "Choose the board's port" and answer the chooser with the CH340
//     shot <file.png> [w h] screenshot of the page at that viewport size (default 1440 x 900)
//     nav <url>            load a URL in the page
'use strict';
const [, , dport, urlPart, cmd, arg] = process.argv;

async function main() {
  const targets = await (await fetch('http://127.0.0.1:' + dport + '/json')).json();
  const t = targets.find(x => x.type === 'page' && x.url.includes(urlPart));
  if (!t) throw new Error('no page with ' + urlPart + ': ' + targets.map(x => x.url).join(', '));
  const ws = new WebSocket(t.webSocketDebuggerUrl);
  await new Promise((res, rej) => { ws.onopen = res; ws.onerror = rej; });
  let id = 0;
  const pending = new Map(), events = [];
  ws.onmessage = m => {
    const d = JSON.parse(m.data);
    if (d.id && pending.has(d.id)) { pending.get(d.id)(d); pending.delete(d.id); }
    else if (d.method) events.push(d);
  };
  const send = (method, params) => new Promise(r => { const i = ++id; pending.set(i, r); ws.send(JSON.stringify({ id: i, method, params: params || {} })); });
  const evalJs = async (expr) => {
    const r = await send('Runtime.evaluate', { expression: expr, awaitPromise: true, userGesture: true, returnByValue: true });
    if (r.error) throw new Error(JSON.stringify(r.error));
    if (r.result.exceptionDetails) throw new Error(JSON.stringify(r.result.exceptionDetails).slice(0, 400));
    return r.result.result.value;
  };
  if (cmd === 'eval') console.log(JSON.stringify(await evalJs(arg), null, 1));
  else if (cmd === 'nav') { await send('Page.enable'); await send('Page.navigate', { url: arg }); await new Promise(r => setTimeout(r, 1500)); console.log('loaded ' + arg); }
  else if (cmd === 'shot') {
    const w = +process.argv[6] || 1440, h = +process.argv[7] || 900;
    await send('Emulation.setDeviceMetricsOverride', { width: w, height: h, deviceScaleFactor: 1, mobile: false });
    await new Promise(r => setTimeout(r, 400));
    const r = await send('Page.captureScreenshot', { format: 'png' });
    require('fs').writeFileSync(arg, Buffer.from(r.result.data, 'base64'));
    console.log('saved ' + arg + ' (' + w + 'x' + h + ')');
  }
  else if (cmd === 'pick') {
    const en = await send('DeviceAccess.enable');
    console.log('DeviceAccess.enable:', JSON.stringify(en.error || 'ok'));
    evalJs("document.getElementById('pick').click(); 'clicked'").then(v => console.log('page:', v));
    const end = Date.now() + 8000;
    let prompt = null;
    while (!prompt && Date.now() < end) {
      await new Promise(r => setTimeout(r, 100));
      prompt = events.find(e => e.method === 'DeviceAccess.deviceRequestPrompted');
    }
    if (!prompt) { console.log('no chooser event; events seen:', events.map(e => e.method).join(', ') || 'none'); }
    else {
      const devs = prompt.params.devices;
      console.log('chooser offers:', JSON.stringify(devs));
      for (let k = 0; k < 30 && !devs.length; k++) { await new Promise(r => setTimeout(r, 200)); }
      const ch = devs.find(d => /CH340|USB.?SERIAL|COM\d/i.test(d.name)) || devs[0];
      if (!ch) console.log('no device listed');
      else console.log('selectPrompt:', JSON.stringify(await send('DeviceAccess.selectPrompt', { id: prompt.params.id, deviceId: ch.id })), ch.name);
      await new Promise(r => setTimeout(r, 1000));
      console.log('page port text:', await evalJs("document.getElementById('port').textContent"));
    }
  }
  ws.close();
}
main().catch(e => { console.log('ERROR ' + e.message); process.exit(1); });
