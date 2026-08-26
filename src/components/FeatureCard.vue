<template>
  <article class="om-card p-6 sm:p-8">
    <div class="om-card-mark flex size-10 items-center justify-center border border-line font-mono text-xs text-forest">
      {{ mark }}
    </div>
    <h3 class="mt-5 text-lg font-semibold text-forest">{{ title }}</h3>
    <p class="om-body mt-3 text-sm"><slot /></p>
  </article>
</template>

<script setup>
defineProps({
  title: { type: String, required: true },
  mark: { type: String, default: "◇" },
});
</script>
