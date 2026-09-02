const ITEM = ".om-card, .om-tile, .om-step, .om-rise-item";

function reducedMotion() {
  return window.matchMedia("(prefers-reduced-motion: reduce)").matches;
}

function revealTargets(root) {
  const out = [];
  root.querySelectorAll("section:not(.om-page-hero)").forEach((section) => {
    const items = [...section.querySelectorAll(ITEM)];
    if (items.length) out.push(...items);
    else out.push(section);
  });
  return out;
}

function itemDelay(el) {
  if (el.matches("section")) return "0ms";
  const section = el.closest("section");
  if (!section) return "0ms";
  const group = [...section.querySelectorAll(ITEM)];
  const index = Math.max(0, group.indexOf(el));
  return `${Math.min(index, 7) * 55}ms`;
}

function clearReveal(el) {
  el.classList.remove("om-reveal", "is-in");
  el.style.removeProperty("--om-delay");
}

function bindReveal(root) {
  root.querySelectorAll(".om-reveal").forEach(clearReveal);
  if (reducedMotion()) return () => {};

  const nodes = revealTargets(root);
  nodes.forEach((el) => {
    el.classList.add("om-reveal");
    el.style.setProperty("--om-delay", itemDelay(el));
  });

  const io = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return;
        entry.target.classList.add("is-in");
        io.unobserve(entry.target);
      });
    },
    { threshold: 0.12, rootMargin: "0px 0px -8% 0px" },
  );

  const start = () => nodes.forEach((el) => io.observe(el));
  requestAnimationFrame(() => requestAnimationFrame(start));

  return () => {
    io.disconnect();
    nodes.forEach(clearReveal);
  };
}

function bindHeroScrub(root) {
  const heroes = [...root.querySelectorAll(".om-page-hero")];
  if (!heroes.length) return () => {};

  const reduce = window.matchMedia("(prefers-reduced-motion: reduce)");
  let ticking = false;

  const update = () => {
    ticking = false;
    if (reduce.matches) {
      heroes.forEach((el) => el.style.setProperty("--om-hero-p", "0"));
      return;
    }
    heroes.forEach((el) => {
      const rect = el.getBoundingClientRect();
      const height = Math.max(el.offsetHeight, 1);
      const progress = Math.min(1, Math.max(0, -rect.top / height));
      el.style.setProperty("--om-hero-p", progress.toFixed(4));
    });
  };

  const onScroll = () => {
    if (ticking) return;
    ticking = true;
    requestAnimationFrame(update);
  };

  window.addEventListener("scroll", onScroll, { passive: true });
  update();

  return () => {
    window.removeEventListener("scroll", onScroll);
    heroes.forEach((el) => el.style.removeProperty("--om-hero-p"));
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
  const stopReveal = revealInView(root);
  const stopHero = bindHeroScrub(root);
  return () => {
    stopReveal();
    stopHero();
  };
}
