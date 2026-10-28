import fs from "node:fs";

const base = "http://127.0.0.1:9222";
const framesDir = "/private/tmp/kulola-demo-frames";
fs.mkdirSync(framesDir, { recursive: true });
for (const file of fs.readdirSync(framesDir)) fs.unlinkSync(`${framesDir}/${file}`);

const targets = await (await fetch(`${base}/json/list`)).json();
const target = targets.find((candidate) => candidate.type === "page");
const ws = new WebSocket(target.webSocketDebuggerUrl);
await new Promise((resolve, reject) => {
  ws.addEventListener("open", resolve, { once: true });
  ws.addEventListener("error", reject, { once: true });
});

let sequence = 0;
const pending = new Map();
ws.addEventListener("message", ({ data }) => {
  const message = JSON.parse(data);
  if (!message.id) return;
  const callback = pending.get(message.id);
  if (callback) {
    pending.delete(message.id);
    callback(message);
  }
});

function command(method, params = {}) {
  const id = ++sequence;
  ws.send(JSON.stringify({ id, method, params }));
  return new Promise((resolve) => pending.set(id, resolve));
}

const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function evaluate(expression) {
  const response = await command("Runtime.evaluate", {
    expression,
    awaitPromise: true,
    returnByValue: true,
  });
  if (response.result?.exceptionDetails) throw new Error(response.result.exceptionDetails.text);
  return response.result?.result?.value;
}

let frame = 0;
async function capture(count = 8, delay = 180) {
  for (let index = 0; index < count; index++) {
    const response = await command("Page.captureScreenshot", {
      format: "jpeg",
      quality: 86,
      captureBeyondViewport: false,
    });
    fs.writeFileSync(
      `${framesDir}/frame-${String(frame++).padStart(4, "0")}.jpg`,
      Buffer.from(response.result.data, "base64"),
    );
    await wait(delay);
  }
}

async function act(expression, pause = 700) {
  await evaluate(expression);
  await wait(pause);
  await capture(5);
}

await command("Emulation.setDeviceMetricsOverride", {
  width: 1440,
  height: 900,
  deviceScaleFactor: 1,
  mobile: false,
});
await command("Page.navigate", { url: "http://localhost:4002/checkout" });
await wait(1200);
await evaluate(`localStorage.setItem("kulola_cart", JSON.stringify([{
  id: "101", key: "101__black__10", name: "Black Striped Pants",
  image: "/images/kulola-logo.png", price: 3500, color: "Black",
  color_id: "black", size: "10", quantity: 1
}]))`);
await command("Page.reload", { ignoreCache: true });
await wait(1800);
await capture(12);

await act(`document.querySelector('input[name="location_scope"][value="outside_nairobi"]').click()`);
await act(`document.querySelector('input[name="location_scope"][value="nairobi"]').click()`);
await act(`document.querySelector('input[name="order_type"][value="delivery"]').click()`);
await act(`document.querySelector('input[name="order_type"][value="fitting"]').click()`);

await act(`document.querySelector('input[name="name"]').scrollIntoView({behavior:"smooth", block:"center"})`, 900);

async function fill(name, value) {
  await act(`(() => {
    const element = document.querySelector('[name="${name}"]');
    const setter = Object.getOwnPropertyDescriptor(
      element.tagName === "SELECT" ? HTMLSelectElement.prototype :
      element.tagName === "TEXTAREA" ? HTMLTextAreaElement.prototype : HTMLInputElement.prototype,
      "value"
    ).set;
    setter.call(element, ${JSON.stringify(value)});
    element.dispatchEvent(new Event("input", {bubbles:true}));
    element.dispatchEvent(new Event("change", {bubbles:true}));
  })()`, 350);
}

await fill("name", "Bridget Wanjiku");
await fill("phone", "0712 345 678");
await fill("email", "bridget@example.com");
await fill("delivery_area", "Kilimani");
await fill("address", "Yaya Centre, Kilimani");
await fill("fitting_date", "2026-11-02");
await fill("fitting_time", "2:00 PM – 4:00 PM");
await act(`document.querySelector('input[name="wants_additional"][value="yes"]').click()`);
for (let attempt = 0; attempt < 20; attempt++) {
  if (await evaluate(`Boolean(document.querySelector('[name="additional_items"]'))`)) break;
  await wait(150);
}
await fill("additional_items", "Brown sweater, size 10");

await act(`document.querySelector('button[type="submit"]').scrollIntoView({behavior:"smooth", block:"center"})`, 900);
await capture(10);
await act(`document.querySelector('button[type="submit"]').click()`, 1800);
await capture(18);

ws.close();
console.log(`${frame} frames captured in ${framesDir}`);
