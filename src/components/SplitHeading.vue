<template>
  <component :is="tag" class="om-split" :aria-label="text">
    <span
      v-for="(word, index) in words"
      :key="`${word}-${index}`"
      class="om-split-word"
      :class="{ 'is-in': ready }"
      :style="{ '--i': index }"
      aria-hidden="true"
    >
      {{ word }}
    </span>
  </component>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref } from "vue";

const props = defineProps({
  text: { type: String, required: true },
  tag: { type: String, default: "h1" },
});

const words = computed(() => props.text.split(" ").filter(Boolean));
const ready = ref(false);
let timer = 0;

onMounted(() => {
  timer = window.setTimeout(() => {
    ready.value = true;
  }, 280);
});

onUnmounted(() => window.clearTimeout(timer));
</script>
