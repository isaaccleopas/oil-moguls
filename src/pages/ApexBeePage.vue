<template>
  <PageHero kicker="A product of Oil Moguls" title="ApexBee is how members practise until the skill holds.">
    Not a separate company. ApexBee is the Oil Moguls practice product: structured drills, exam readiness, and progress you can see.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container grid gap-12 lg:grid-cols-2">
      <SectionHeading kicker="Why it exists" title="A course is incomplete without practice.">
        Oil Moguls is a learning community. ApexBee is the product that turns that learning into repetition, diagnosis, and proof.
      </SectionHeading>
      <div class="space-y-5 om-body">
        <p>Members preparing for professional programmes, leadership tracks, HSE, and regulatory work need more than slides. They need drills that match how the sector actually examines competence.</p>
        <p>ApexBee is built for those members: engineers, operators, graduates, HSE and procurement professionals, and anyone in this community who has to show they can do the work.</p>
      </div>
    </div>
  </section>
  <section class="border-y border-line bg-white py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="Inside the product" title="Practice with a point." />
      <div class="mt-12 grid gap-4 md:grid-cols-3">
        <FeatureCard title="Targeted drills" mark="01">Short, serious practice sessions on the modules that matter for oil and gas professional programmes, not trivia.</FeatureCard>
        <FeatureCard title="Visible progress" mark="02">Coverage, weak spots, and the next drill worth doing. Competence is currency; ApexBee makes it measurable.</FeatureCard>
        <FeatureCard title="Programme depth" mark="03">Built around real tracks members sit: leadership, operations, HSE, regulation, and the business of oil and gas.</FeatureCard>
      </div>
    </div>
  </section>
  <section class="py-16 sm:py-24">
    <div class="om-container grid gap-10 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
      <div>
        <h2 class="om-display text-3xl">How ApexBee sits in Oil Moguls</h2>
        <p class="om-body mt-4">Academy teaches. ApexBee practises. Community and mentorship put people around you. The Opportunity Board and Conference are where that competence meets access.</p>
      </div>
      <div class="om-card p-6 sm:p-8">
        <p class="font-mono text-xs tracking-[0.18em] uppercase text-muted">Product of</p>
        <p class="mt-3 text-lg font-semibold text-forest">Oil Moguls</p>
        <p class="om-body mt-3 text-sm">Same brand, same standard, same members. ApexBee is not a generic exam app with an oil-and-gas skin.</p>
      </div>
    </div>
  </section>
  <section class="om-hero-mesh py-16 sm:py-24">
    <div class="om-container flex flex-col gap-6 sm:flex-row sm:items-end sm:justify-between">
      <div class="max-w-xl">
        <h2 class="om-display om-display-light text-3xl text-offwhite">Open ApexBee. Practise until the skill holds.</h2>
        <p class="mt-3 text-offwhite/70">ApexBee is live. Launch the product, or request community access if you are not a member yet.</p>
      </div>
      <div class="flex flex-col gap-3 sm:flex-row">
        <a id="apexbee-launch" :href="APEXBEE_URL" class="om-btn om-btn-sage" target="_blank" rel="noopener noreferrer">Launch ApexBee</a>
        <RouterLink to="/join" class="om-btn om-btn-ghost">Request access</RouterLink>
      </div>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";
import FeatureCard from "../components/FeatureCard.vue";
import { APEXBEE_URL } from "../content";
</script>
