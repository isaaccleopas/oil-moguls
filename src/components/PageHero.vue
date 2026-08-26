<template>
  <section class="om-hero-mesh relative overflow-hidden">
    <div class="om-container relative z-10 py-16 sm:py-20 lg:py-24">
      <p class="om-eyebrow om-eyebrow-light">{{ kicker }}</p>
      <h1 class="om-display om-display-light mt-5 max-w-3xl text-4xl sm:text-5xl lg:text-[3.25rem]">
        {{ title }}
      </h1>
      <p class="mt-5 max-w-xl text-base leading-relaxed text-offwhite/75 sm:text-lg">
        <slot />
      </p>
    </div>
  </section>
</template>

<script setup>
defineProps({
  kicker: { type: String, default: "Oil Moguls" },
  title: { type: String, required: true },
});
</script>
