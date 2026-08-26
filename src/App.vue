<template>
  <a
    href="#main"
    class="sr-only focus:not-sr-only focus:absolute focus:left-4 focus:top-4 focus:z-50 focus:bg-forest focus:px-4 focus:py-2 focus:text-offwhite"
  >
    Skip to content
  </a>
  <div class="flex min-h-screen flex-col">
    <SiteNav />
    <main id="main" class="flex-1">
      <RouterView />
    </main>
    <SiteFooter />
  </div>
</template>

<script setup>
import { RouterView } from "vue-router";
import SiteNav from "./components/SiteNav.vue";
import SiteFooter from "./components/SiteFooter.vue";
</script>
