<template>
  <PageHero kicker="Community" title="A professional network with standards.">
    Every member here is building a career in or around oil and gas. Oil Moguls is the community they join, not a company that operates in the field.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container grid gap-12 lg:grid-cols-2 lg:items-start">
      <SectionHeading kicker="The standard" title="Competence is currency.">
        Follower counts do not run this community. Verified credentials, demonstrated skill, and contribution do.
      </SectionHeading>
      <div class="space-y-8">
        <p class="om-body text-base sm:text-lg">Informal networks left access to chance. Oil Moguls engineers mentorship and introductions so you are not dependent on who you already know.</p>
        <p class="om-body">Moderation is visible. Community standards are enforced. That is how trust stays non-negotiable as the network grows.</p>
      </div>
    </div>
  </section>
  <section class="border-y border-line bg-white py-16 sm:py-24">
    <div class="om-container">
      <SectionHeading kicker="What you join" title="Mentorship, peers, and a room worth being in." />
      <div class="mt-12 grid gap-4 md:grid-cols-3">
        <FeatureCard title="Verified mentors" mark="01">People who have sat through a well-control course and a procurement negotiation. They share what they know instead of protecting it.</FeatureCard>
        <FeatureCard title="Peer community" mark="02">Students, graduates, engineers, geoscientists, operators, HSE and procurement professionals, executives, consultants, trainers, and the institutions around them.</FeatureCard>
        <FeatureCard title="Trust you can see" mark="03">Verification badges on mentors and members. No fake experts. No unverified rooms dressed up as access.</FeatureCard>
      </div>
    </div>
  </section>
  <section class="bg-night py-16 text-offwhite sm:py-24">
    <div class="om-container max-w-3xl">
      <p class="om-eyebrow om-eyebrow-light">Community compounds</p>
      <h2 class="om-display om-display-light mt-5 text-3xl sm:text-4xl">Every member who joins should make the platform more valuable for everyone already there.</h2>
      <p class="mt-6 text-offwhite/70">That is the design test. If a feature only extracts attention, it does not belong here.</p>
      <RouterLink to="/join" class="om-btn om-btn-sage mt-8">Become a member</RouterLink>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";
import FeatureCard from "../components/FeatureCard.vue";
</script>
