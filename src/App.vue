<template>
  <a
    href="#main"
    class="sr-only focus:not-sr-only focus:absolute focus:left-4 focus:top-4 focus:z-50 focus:bg-forest focus:px-4 focus:py-2 focus:text-offwhite"
  >
    Skip to content
  </a>
  <ScrollProgress />
  <div class="om-veil" :class="veilClass" aria-hidden="true" />
  <div class="flex min-h-screen flex-col">
    <SiteNav />
    <main id="main" class="flex-1">
      <RouterView v-slot="{ Component }">
        <component :is="Component" :key="route.fullPath" @vue:mounted="onPageEnter" />
      </RouterView>
    </main>
    <SiteFooter />
  </div>
</template>

<script setup>
import { nextTick, onUnmounted, ref, watch } from "vue";
import { RouterView, useRoute } from "vue-router";
import ScrollProgress from "./components/ScrollProgress.vue";
import SiteFooter from "./components/SiteFooter.vue";
import SiteNav from "./components/SiteNav.vue";
import { enhancePage } from "./motion";

const route = useRoute();
const veilClass = ref("");
let stopEnhance = () => {};
let coverTimer = 0;
let uncoverTimer = 0;

async function onPageEnter() {
  stopEnhance?.();
  await nextTick();
  stopEnhance = enhancePage(document.getElementById("main") || document);
}

function playVeil() {
  window.clearTimeout(coverTimer);
  window.clearTimeout(uncoverTimer);
  veilClass.value = "is-covering";
  coverTimer = window.setTimeout(() => {
    veilClass.value = "is-uncovering";
    uncoverTimer = window.setTimeout(() => {
      veilClass.value = "";
    }, 520);
  }, 320);
}

watch(
  () => route.fullPath,
  (_now, prev) => {
    if (prev !== undefined) playVeil();
  },
);

onUnmounted(() => {
  stopEnhance?.();
  window.clearTimeout(coverTimer);
  window.clearTimeout(uncoverTimer);
});
</script>
