<template>
  <PageHero kicker="About" title="A learning community. Not an oil and gas company.">
    Oil Moguls exists to challenge the gatekeeping that has held back capable oil and gas professionals, and to open up learning, relationships, and access in its place.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container max-w-3xl">
      <p class="om-eyebrow">What we are</p>
      <div class="om-body mt-8 space-y-5 text-base sm:text-lg">
        <p>We do not drill, produce, refine, or sell field services. Oil Moguls is the learning community those professionals join: structured education, mentorship, verified opportunity, and products such as ApexBee.</p>
        <p>The oil and gas industry runs on relationships and knowledge that are hard to access. Career progression has depended less on what a professional knows and more on who they know, which company they started at, and which rooms they were invited into.</p>
        <p>That gatekeeping has quietly excluded capable engineers, geoscientists, operators, and graduates from opportunities they were qualified for. We built a community so learning has somewhere to connect to practice, people, and work.</p>
      </div>
    </div>
  </section>
  <section class="border-y border-line bg-white py-16 sm:py-24">
    <div class="om-container grid gap-10 lg:grid-cols-3">
      <div>
        <p class="text-xs font-medium tracking-[0.18em] uppercase text-muted">Purpose</p>
        <p class="mt-4 text-night">Challenge gatekeeping. Open up learning, relationships, and access for people in oil and gas.</p>
      </div>
      <div>
        <p class="text-xs font-medium tracking-[0.18em] uppercase text-muted">Vision</p>
        <p class="mt-4 text-night">Become Africa's leading learning and professional community for oil and gas professionals, and help make the Nigerian sector globally competitive.</p>
      </div>
      <div>
        <p class="text-xs font-medium tracking-[0.18em] uppercase text-muted">Mission</p>
        <p class="mt-4 text-night">Give every serious oil and gas professional the knowledge, relationships, and tools they need to succeed.</p>
      </div>
    </div>
  </section>
  <section class="py-16 sm:py-24">
    <div class="om-container grid gap-12 lg:grid-cols-2 lg:items-center">
      <SectionHeading kicker="Products" title="ApexBee is ours.">
        ApexBee is a product of Oil Moguls: the practice layer beside Academy, community, and Conference. Same standard. Same members.
      </SectionHeading>
      <div class="flex flex-col gap-3 sm:flex-row sm:items-center">
        <a :href="APEXBEE_URL" class="om-btn om-btn-primary w-full sm:w-fit" target="_blank" rel="noopener noreferrer">Launch ApexBee</a>
        <RouterLink to="/apexbee" class="om-btn om-btn-outline w-full sm:w-fit">How it fits</RouterLink>
      </div>
    </div>
  </section>
  <section class="border-t border-line bg-white py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="Values" title="What we will not trade away." />
      <div class="mt-12 grid gap-8 sm:grid-cols-2">
        <article v-for="value in values" :key="value.title" class="om-rise-item border-t border-line pt-6">
          <h2 class="font-semibold text-forest">{{ value.title }}</h2>
          <p class="om-body mt-2 text-sm">{{ value.body }}</p>
        </article>
      </div>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";
import { APEXBEE_URL } from "../content";

const values = [
  { title: "Access over gatekeeping", body: "Every product decision is tested against one question: does this make opportunity more accessible, or less?" },
  { title: "Competence is currency", body: "Members earn standing through demonstrated skill and contribution, not proximity to power." },
  { title: "Radical usefulness", body: "We measure value in opportunities generated, not engagement metrics." },
  { title: "Trust is non-negotiable", body: "We verify before we publish, vet before we platform, and protect members' time and reputation." },
  { title: "Community compounds", body: "Every member who joins should make the platform more valuable for everyone already there." },
  { title: "Built for Africa, built to compete globally", body: "Deep respect for local industry realities, held to global standards of quality and technology." },
  { title: "Progress over perfection", body: "We ship, learn, and improve in public. The industry's problems are too urgent for perfectionism." },
  { title: "Dignity for every professional", body: "From the final-year student to the regulator, every member is treated as a serious professional." },
];
</script>
