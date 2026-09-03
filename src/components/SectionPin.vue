<template>
  <div class="om-pin-kicker">
    <div class="om-container">
      <p class="om-eyebrow">{{ label }}</p>
    </div>
  </div>
</template>

<script setup>
defineProps({
  label: { type: String, required: true },
});
</script>
