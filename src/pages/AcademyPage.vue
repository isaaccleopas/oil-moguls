<template>
  <PageHero kicker="Oil Moguls Academy" title="Master the skill the way working professionals do.">
    Practical, verified courses for people in oil and gas, not for an oil company to run its assets. Learning starts here; ApexBee is where you practise it.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="Tracks" title="Curriculum with sector depth.">
        Named disciplines. No generic professional-development filler. Each track is designed to turn into work.
      </SectionHeading>
      <div class="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <article v-for="track in tracks" :key="track.code" class="om-card p-6 sm:p-8">
          <p class="font-mono text-xs text-muted">{{ track.code }}</p>
          <h2 class="mt-3 text-lg font-semibold text-forest">{{ track.title }}</h2>
          <p class="om-body mt-3 text-sm">{{ track.body }}</p>
        </article>
      </div>
    </div>
  </section>
  <section class="border-y border-line bg-white py-16 sm:py-24">
    <div class="om-container grid gap-12 lg:grid-cols-2">
      <SectionHeading kicker="How we teach" title="Substance first. Credentials follow.">
        We respect expertise above titles. Members earn standing through demonstrated skill, not proximity to power.
      </SectionHeading>
      <ul class="space-y-6">
        <li v-for="item in principles" :key="item.title" class="border-t border-line pt-6">
          <h3 class="font-semibold text-forest">{{ item.title }}</h3>
          <p class="om-body mt-2 text-sm">{{ item.body }}</p>
        </li>
      </ul>
    </div>
  </section>
  <section class="py-16 sm:py-24">
    <div class="om-container flex flex-col gap-6 sm:flex-row sm:items-end sm:justify-between">
      <div class="max-w-xl">
        <h2 class="om-display text-3xl">Join a cohort. Put the skill to work.</h2>
        <p class="om-body mt-3">Completing a module should lead somewhere: ApexBee practice, a mentor, a verified listing, a stronger profile.</p>
      </div>
      <div class="flex flex-col gap-3 sm:flex-row">
        <RouterLink to="/join" class="om-btn om-btn-primary">Apply for the Academy</RouterLink>
        <a :href="APEXBEE_URL" class="om-btn om-btn-outline" target="_blank" rel="noopener noreferrer">Practise on ApexBee</a>
      </div>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";
import { APEXBEE_URL } from "../content";

const tracks = [
  { code: "DRL", title: "Drilling & well operations", body: "Well control, planning, and field decision-making taught as they are used on the job." },
  { code: "GEO", title: "Geoscience", body: "Subsurface interpretation, data practice, and the software fluency specialist roles require." },
  { code: "HSE", title: "Health, safety & environment", body: "Regulation, culture, and verifiable certification pathways that hold up under audit." },
  { code: "PRC", title: "Procurement & contracting", body: "Supplier landscapes, compliance, and strategic sourcing for operators and service companies." },
  { code: "OPS", title: "Production & operations", body: "Supervisory skills and practical upskilling that fit rotation schedules, not classroom fiction." },
  { code: "LDR", title: "Leadership & commercial", body: "The language of the boardroom, without talking down to anyone still on the way there." },
];

const principles = [
  { title: "Practice over slides", body: "Content has to produce a tangible outcome for a member's career. If it cannot, it does not ship." },
  { title: "Verified instructors", body: "We do not platform unqualified experts. Mentors and faculty are vetted before they teach." },
  { title: "Visible progress", body: "Completion is marked, shareable, and tied to the profile that recruiters and mentors actually read." },
];
</script>
