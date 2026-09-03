<template>
  <div class="om-rise-item max-w-2xl">
    <p v-if="kicker" class="om-eyebrow" :class="light && 'om-eyebrow-light'">{{ kicker }}</p>
    <h2 class="om-display text-3xl sm:text-4xl" :class="[kicker ? 'mt-5' : '', light && 'om-display-light']">{{ title }}</h2>
    <div v-if="$slots.default" class="om-body mt-4 text-base sm:text-lg" :class="light && 'text-offwhite/70'">
      <slot />
    </div>
  </div>
</template>

<script setup>
defineProps({
  kicker: { type: String, default: "" },
  title: { type: String, required: true },
  light: { type: Boolean, default: false },
});
</script>
