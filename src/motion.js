const ITEM = ".om-card, .om-tile, .om-step, .om-rise-item";

function isMobile() {
  return window.matchMedia("(max-width: 767px)").matches;
}

function revealTargets(root) {
  if (!isMobile()) {
    return [...root.querySelectorAll("section:not(.om-page-hero)")];
  }
  const items = [...root.querySelectorAll(ITEM)];
  const sections = [...root.querySelectorAll("section:not(.om-page-hero)")].filter(
    (section) => !section.querySelector(ITEM),
  );
  return [...sections, ...items];
}

function snapOut(el) {
  el.style.transition = "none";
  el.classList.remove("is-in");
  void el.offsetWidth;
  el.style.removeProperty("transition");
}

function clearReveal(el) {
  el.classList.remove("om-reveal", "is-in");
  el.style.removeProperty("--om-delay");
}

function itemDelay(el, index) {
  if (!isMobile()) return `${(index % 4) * 55}ms`;
  return "0ms";
}

function bindReveal(root) {
  root.querySelectorAll(".om-reveal").forEach(clearReveal);

  const nodes = revealTargets(root);
  nodes.forEach((el, index) => {
    el.classList.add("om-reveal");
    el.style.setProperty("--om-delay", itemDelay(el, index));
  });

  const io = new IntersectionObserver(
    (entries) => {
      const vh = window.innerHeight || 1;
      entries.forEach((entry) => {
        const el = entry.target;
        const { top, bottom } = entry.boundingClientRect;
        if (entry.isIntersecting) {
          el.classList.add("is-in");
          return;
        }
        if (bottom < 0 || top > vh) snapOut(el);
      });
    },
    { threshold: [0, 0.12], rootMargin: "0px 0px -10% 0px" },
  );

  const start = () => nodes.forEach((el) => io.observe(el));
  requestAnimationFrame(() => requestAnimationFrame(start));

  return () => {
    io.disconnect();
    nodes.forEach(clearReveal);
  };
}

export function revealInView(root = document) {
  let stop = () => {};
  const mq = window.matchMedia("(max-width: 767px)");

  const setup = () => {
    stop();
    stop = bindReveal(root);
  };

  setup();
  mq.addEventListener("change", setup);

  return () => {
    mq.removeEventListener("change", setup);
    stop();
  };
}

export function enhancePage(root = document) {
  return revealInView(root);
}
