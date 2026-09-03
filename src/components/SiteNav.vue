<template>
  <header
    class="om-header sticky top-0 z-40 border-b border-line/80 bg-offwhite/92 backdrop-blur-md"
    :data-compact="String(compact)"
  >
    <div class="om-nav-bar om-container flex items-center justify-between gap-4">
      <RouterLink to="/" class="om-wordmark-link shrink-0" aria-label="Oil Moguls home">
        <Wordmark />
      </RouterLink>

      <nav class="hidden items-center gap-6 xl:flex" aria-label="Primary">
        <template v-for="item in navItems" :key="item.label">
          <a
            v-if="item.href"
            :href="item.href"
            class="om-nav-link"
            target="_blank"
            rel="noopener noreferrer"
          >
            {{ item.label }}
          </a>
          <RouterLink
            v-else
            :to="item.to"
            class="om-nav-link"
            :data-active="String(isActive(item.to))"
          >
            {{ item.label }}
          </RouterLink>
        </template>
      </nav>

      <div class="hidden items-center gap-3 xl:flex">
        <RouterLink to="/audiences" class="om-nav-link">Who we serve</RouterLink>
        <RouterLink to="/join" class="om-btn om-btn-primary">Join the community</RouterLink>
      </div>

      <button
        type="button"
        class="om-burger inline-flex size-11 items-center justify-center text-forest xl:hidden"
        aria-controls="mobile-nav"
        :aria-expanded="open ? 'true' : 'false'"
        :aria-label="open ? 'Close menu' : 'Open menu'"
        :data-open="String(open)"
        @click="open = !open"
      >
        <span class="om-burger-lines" aria-hidden="true">
          <span></span>
          <span></span>
        </span>
      </button>
    </div>

    <transition name="om-drawer">
      <div v-if="open" id="mobile-nav" class="border-t border-line bg-offwhite xl:hidden">
        <nav class="om-container flex flex-col gap-1 py-4" aria-label="Mobile">
          <template v-for="item in navItems" :key="item.label">
            <a
              v-if="item.href"
              :href="item.href"
              class="flex min-h-11 items-center text-base font-medium text-night"
              target="_blank"
              rel="noopener noreferrer"
            >
              {{ item.label }}
            </a>
            <RouterLink
              v-else
              :to="item.to"
              class="flex min-h-11 items-center text-base font-medium text-night"
              @click="open = false"
            >
              {{ item.label }}
            </RouterLink>
          </template>
          <RouterLink
            to="/audiences"
            class="flex min-h-11 items-center text-base font-medium text-night"
            @click="open = false"
          >
            Who we serve
          </RouterLink>
          <RouterLink to="/join" class="om-btn om-btn-primary mt-3 w-full" @click="open = false">
            Join the community
          </RouterLink>
        </nav>
      </div>
    </transition>
  </header>
</template>

<script setup>
import { onMounted, onUnmounted, ref, watch } from "vue";
import { RouterLink, useRoute } from "vue-router";
import Wordmark from "./Wordmark.vue";
import { APEXBEE_URL } from "../content";

const route = useRoute();
const open = ref(false);
const compact = ref(false);

function syncCompactNav() {
  document.documentElement.dataset.compactNav = String(compact.value);
}

const navItems = [
  { label: "Academy", to: "/academy" },
  { label: "ApexBee", href: APEXBEE_URL },
  { label: "Community", to: "/community" },
  { label: "Opportunities", to: "/opportunities" },
  { label: "Conference", to: "/conference" },
];

const isActive = (to) => route.path === to;

function onScroll() {
  compact.value = window.scrollY > 16;
}

watch(
  () => route.fullPath,
  () => {
    open.value = false;
  },
);

watch(compact, syncCompactNav);

onMounted(() => {
  window.addEventListener("scroll", onScroll, { passive: true });
  onScroll();
  syncCompactNav();
});

onUnmounted(() => {
  window.removeEventListener("scroll", onScroll);
  delete document.documentElement.dataset.compactNav;
});
</script>
