<template>
  <section class="om-page-hero om-hero-mesh relative overflow-hidden" :class="{ 'is-live': live }">
    <HeroOrbs />
    <div class="om-container relative z-10 py-12 sm:py-20 lg:py-24">
      <p class="om-eyebrow om-eyebrow-light om-hero-kicker">{{ kicker }}</p>
      <SplitHeading
          class="om-display om-display-light mt-5 max-w-3xl text-[1.85rem] sm:text-5xl lg:text-[3.25rem]"
        :text="title"
      />
      <p class="om-hero-copy mt-5 max-w-xl text-base leading-relaxed text-offwhite/75 sm:text-lg">
        <slot />
      </p>
    </div>
  </section>
</template>

<script setup>
import { onMounted, ref } from "vue";
import HeroOrbs from "./HeroOrbs.vue";
import SplitHeading from "./SplitHeading.vue";

defineProps({
  kicker: { type: String, default: "Oil Moguls" },
  title: { type: String, required: true },
});

const live = ref(false);
onMounted(() => {
  requestAnimationFrame(() => {
    live.value = true;
  });
});
</script>
