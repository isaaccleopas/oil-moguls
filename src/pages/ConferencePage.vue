<template>
  <PageHero kicker="The Oil Moguls Conference" title="Where the next generation of oil and gas professionals shows up to learn, connect, and get seen.">
    A gathering of the community, not an energy expo and not a company offsite. If you are serious about a career in this sector, this is the room.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container grid gap-12 lg:grid-cols-2">
      <SectionHeading kicker="Core product" title="The gathering that puts the community in one room.">
        The Conference is a flagship of Oil Moguls the learning community: the moment Academy, ApexBee, mentorship, and opportunity occupy the same physical space.
      </SectionHeading>
      <div class="space-y-6 om-body">
        <p>Members meet operators, service companies, mentors, and peers with the same standard they already know on the platform: verified, specific, and built for people who do the work.</p>
        <p>Alongside the Conference, the Oil Moguls Incubator develops the next leaders of the community itself, so the standard scales without thinning.</p>
      </div>
    </div>
  </section>
  <section class="border-y border-line bg-white py-16 sm:py-24">
    <div class="om-container grid gap-4 md:grid-cols-3">
      <FeatureCard title="Substance on stage" mark="01">Technical sessions and career briefings from people inside the industry. No outsider keynotes dressed as insight.</FeatureCard>
      <FeatureCard title="Access you can use" mark="02">Structured introductions, mentor hours, and hiring conversations with a vetted talent pool.</FeatureCard>
      <FeatureCard title="Built for this market" mark="03">Hosted where African oil and gas talent actually lives and works, starting with Nigeria.</FeatureCard>
    </div>
  </section>
  <section class="py-16 sm:py-24">
    <div class="om-container flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
      <div class="max-w-xl">
        <h2 class="om-display text-3xl">Reserve your place for the next gathering.</h2>
        <p class="om-body mt-3">Tell us who you are. We will follow up with dates, format, and the right ticket path, including groups from service companies, campuses, and professional bodies.</p>
      </div>
      <RouterLink to="/join" class="om-btn om-btn-primary">Register interest</RouterLink>
    </div>
  </section>
</template>

<script setup>
import { RouterLink } from "vue-router";
import PageHero from "../components/PageHero.vue";
import SectionHeading from "../components/SectionHeading.vue";
import FeatureCard from "../components/FeatureCard.vue";
</script>
