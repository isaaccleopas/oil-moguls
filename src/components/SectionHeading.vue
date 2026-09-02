<template>
  <div class="om-rise-item max-w-2xl">
    <p class="om-eyebrow" :class="light && 'om-eyebrow-light'">{{ kicker }}</p>
    <h2 class="om-display mt-5 text-3xl sm:text-4xl" :class="light && 'om-display-light'">{{ title }}</h2>
    <div v-if="$slots.default" class="om-body mt-4 text-base sm:text-lg" :class="light && 'text-offwhite/70'">
      <slot />
    </div>
  </div>
</template>

<script setup>
defineProps({
  kicker: { type: String, required: true },
  title: { type: String, required: true },
  light: { type: Boolean, default: false },
});
</script>
