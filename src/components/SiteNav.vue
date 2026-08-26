<template>
  <header class="sticky top-0 z-40 border-b border-line/80 bg-offwhite/92 backdrop-blur-md">
    <div class="om-container flex h-16 items-center justify-between gap-4 lg:h-[4.5rem]">
      <RouterLink to="/" class="shrink-0" aria-label="Oil Moguls home">
        <Wordmark />
      </RouterLink>

      <nav class="hidden items-center gap-7 lg:flex" aria-label="Primary">
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

      <div class="hidden items-center gap-3 lg:flex">
        <RouterLink to="/audiences" class="om-nav-link">Who we serve</RouterLink>
        <RouterLink to="/join" class="om-btn om-btn-primary">Join the community</RouterLink>
      </div>

      <button
        type="button"
        class="inline-flex size-11 items-center justify-center text-forest lg:hidden"
        aria-controls="mobile-nav"
        :aria-expanded="open ? 'true' : 'false'"
        aria-label="Open menu"
        @click="open = !open"
      >
        <span class="text-2xl leading-none">{{ open ? "×" : "☰" }}</span>
      </button>
    </div>

    <div v-show="open" id="mobile-nav" class="border-t border-line bg-offwhite lg:hidden">
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
  </header>
</template>

<script setup>
import { ref } from "vue";
import { RouterLink, useRoute } from "vue-router";
import Wordmark from "./Wordmark.vue";
import { APEXBEE_URL } from "../content";

const route = useRoute();
const open = ref(false);

const navItems = [
  { label: "Academy", to: "/academy" },
  { label: "ApexBee", href: APEXBEE_URL },
  { label: "Community", to: "/community" },
  { label: "Opportunities", to: "/opportunities" },
  { label: "Conference", to: "/conference" },
];

const isActive = (to) => route.path === to;
</script>
