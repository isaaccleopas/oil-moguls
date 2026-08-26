<template>
  <PageHero kicker="Opportunity Board" title="Your next role should not depend on who you happen to know.">
    A verified board for members of the community. Oil Moguls platforms opportunity. We are not the employer, the operator, or the agency behind the listing.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="How the board works" title="Verified in. Noise out.">
        We do not platform unverified roles, unpaid bait, or vague “opportunity” posts. Member time is treated as carefully as our own reputation.
      </SectionHeading>
      <div class="mt-12 overflow-hidden rounded-sm border border-line">
        <div class="grid grid-cols-[1fr_auto] gap-4 border-b border-line bg-white px-4 py-3 text-xs font-medium tracking-[0.14em] uppercase text-muted sm:grid-cols-[2fr_1fr_1fr_auto] sm:px-6">
          <span>Role</span>
          <span class="hidden sm:inline">Discipline</span>
          <span class="hidden sm:inline">Type</span>
          <span>Status</span>
        </div>
        <article
          v-for="role in roles"
          :key="role.title"
          class="grid grid-cols-[1fr_auto] items-center gap-4 border-b border-line bg-offwhite px-4 py-5 last:border-b-0 sm:grid-cols-[2fr_1fr_1fr_auto] sm:px-6"
        >
          <div>
            <h2 class="font-semibold text-forest">{{ role.title }}</h2>
            <p class="mt-1 text-sm text-muted">{{ role.company }}</p>
            <p class="mt-2 text-sm text-muted sm:hidden">{{ role.discipline }} · {{ role.type }}</p>
          </div>
          <p class="hidden text-sm text-night sm:block">{{ role.discipline }}</p>
          <p class="hidden text-sm text-night sm:block">{{ role.type }}</p>
          <span class="inline-flex items-center gap-1.5 font-mono text-xs text-forest">
            <span class="size-1.5 rounded-full bg-success"></span>
            Verified
          </span>
        </article>
      </div>
      <p class="mt-4 text-sm text-muted">Illustrative listings. Live roles appear to members after verification.</p>
    </div>
  </section>
  <section class="border-t border-line bg-white py-16 sm:py-24">
    <div class="om-container grid gap-8 lg:grid-cols-3">
      <div class="lg:col-span-2">
        <h2 class="om-display text-3xl">Apply from a profile that already proves the work.</h2>
        <p class="om-body mt-4 max-w-xl">The board is connected to Academy progress and community standing. That is the difference between a job feed and career infrastructure.</p>
      </div>
      <div class="flex items-end">
        <RouterLink to="/join" class="om-btn om-btn-primary w-full lg:w-auto">See verified roles</RouterLink>
      </div>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";

const roles = [
  { title: "Wellsite drilling engineer", company: "Independent operator · Niger Delta", discipline: "Drilling", type: "Full-time" },
  { title: "HSE advisor, production assets", company: "Service company · Port Harcourt", discipline: "HSE", type: "Contract" },
  { title: "Procurement analyst, wells", company: "IOC joint venture", discipline: "Procurement", type: "Full-time" },
  { title: "Graduate geoscience intern", company: "National operator", discipline: "Geoscience", type: "Early career" },
];
</script>
