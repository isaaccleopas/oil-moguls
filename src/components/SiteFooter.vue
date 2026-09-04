<template>
  <footer class="bg-night text-offwhite">
    <div class="om-container grid gap-10 py-16 sm:grid-cols-2 lg:grid-cols-4 lg:gap-12 lg:py-20">
      <div class="sm:col-span-2 lg:col-span-1">
        <Wordmark variant="light" />
        <p class="mt-5 max-w-xs text-sm leading-relaxed text-offwhite/90">
          A learning community for oil and gas professionals, not an oil and gas company. Knowledge, practice, and access in one place.
        </p>
      </div>
      <div>
        <p class="text-xs font-medium tracking-[0.18em] uppercase text-offwhite/50">Products</p>
        <ul class="mt-4 space-y-3 text-sm">
          <li><RouterLink to="/academy" class="om-footer-link">Academy</RouterLink></li>
          <li>
            <a :href="APEXBEE_URL" class="om-footer-link" target="_blank" rel="noopener noreferrer">ApexBee</a>
          </li>
          <li><RouterLink to="/community" class="om-footer-link">Community</RouterLink></li>
          <li><RouterLink to="/opportunities" class="om-footer-link">Opportunity Board</RouterLink></li>
          <li><RouterLink to="/conference" class="om-footer-link">Conference</RouterLink></li>
        </ul>
      </div>
      <div>
        <p class="text-xs font-medium tracking-[0.18em] uppercase text-offwhite/50">Community</p>
        <ul class="mt-4 space-y-3 text-sm">
          <li><RouterLink to="/audiences" class="om-footer-link">Who we serve</RouterLink></li>
          <li><RouterLink to="/about" class="om-footer-link">About</RouterLink></li>
          <li><RouterLink to="/join" class="om-footer-link">Join</RouterLink></li>
        </ul>
      </div>
      <div>
        <p class="text-xs font-medium tracking-[0.18em] uppercase text-offwhite/50">Tagline</p>
        <p class="mt-4 text-sm leading-relaxed text-offwhite/80">Access is earned. We make sure it's possible.</p>
      </div>
    </div>
    <div class="border-t border-white/10">
      <div class="om-container flex flex-col gap-2 py-6 text-xs text-offwhite/45 sm:flex-row sm:items-center sm:justify-between">
        <p>© {{ year }} Oil Moguls. A learning community. Built for Africa.</p>
        <p class="font-mono">Not an oil company. Built for oil and gas professionals.</p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { RouterLink } from "vue-router";
import Wordmark from "./Wordmark.vue";
import { APEXBEE_URL } from "../content";

const year = new Date().getFullYear();
</script>
