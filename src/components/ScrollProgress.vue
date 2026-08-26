<template>
  <div class="om-progress" aria-hidden="true">
    <span class="om-progress-bar" :style="{ transform: `scaleX(${progress})` }" />
  </div>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from "vue";

const progress = ref(0);

function onScroll() {
  const doc = document.documentElement;
  const max = doc.scrollHeight - doc.clientHeight;
  progress.value = max > 0 ? doc.scrollTop / max : 0;
}

onMounted(() => {
  window.addEventListener("scroll", onScroll, { passive: true });
  onScroll();
});

onUnmounted(() => {
  window.removeEventListener("scroll", onScroll);
});
</script>
