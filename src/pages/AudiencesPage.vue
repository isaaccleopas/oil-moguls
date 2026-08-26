<template>
  <PageHero kicker="Who we serve" title="Built for people in oil and gas. Not as an oil and gas company.">
    Oil Moguls does not operate wells, run plants, or sell field services. We are the learning community those professionals join.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container max-w-3xl">
      <p class="om-body text-base sm:text-lg">
        Thirteen audiences. Students through regulators. If you are building a career, teaching the sector, hiring from it, investing around it, or governing it, you belong here as a member of the community, not as a customer of an oil company.
      </p>
    </div>
  </section>
  <section class="border-y border-line bg-white py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="Professionals" title="The people doing the work, and those trying to get in." />
      <div class="mt-12 grid gap-8 sm:grid-cols-2">
        <article v-for="persona in professionals" :key="persona.name" class="border-t border-line pt-6">
          <h2 class="font-semibold text-forest">{{ persona.name }}</h2>
          <p class="om-body mt-2 text-sm">{{ persona.body }}</p>
        </article>
      </div>
    </div>
  </section>
  <section class="py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="Institutions in the community" title="Service companies, investors, trainers, and regulators sit here too.">
        They join as members of the same community. Oil Moguls is not their competitor in the field. It is the room where their people learn and where serious professionals already are.
      </SectionHeading>
      <div class="mt-12 grid gap-8 sm:grid-cols-2">
        <article v-for="persona in institutions" :key="persona.name" class="border-t border-line pt-6">
          <h2 class="font-semibold text-forest">{{ persona.name }}</h2>
          <p class="om-body mt-2 text-sm">{{ persona.body }}</p>
        </article>
      </div>
    </div>
  </section>
  <section class="om-hero-mesh py-16 sm:py-24">
    <div class="om-container flex flex-col gap-6 sm:flex-row sm:items-center sm:justify-between">
      <div class="max-w-xl">
        <h2 class="om-display om-display-light text-3xl text-offwhite">Find your path in the community.</h2>
        <p class="mt-3 text-offwhite/70">The join form asks who you are so we send you to Academy, ApexBee, Conference, or the right room, not a generic sales track.</p>
      </div>
      <RouterLink to="/join" class="om-btn om-btn-sage">Join as you are</RouterLink>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";
import { audiences } from "../content";

const professionals = audiences.slice(0, 9);
const institutions = audiences.slice(9);
</script>
