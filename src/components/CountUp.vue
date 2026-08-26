<template>
  <span>{{ shown }}</span>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from "vue";

const props = defineProps({
  value: { type: Number, required: true },
  prefix: { type: String, default: "" },
  suffix: { type: String, default: "" },
  duration: { type: Number, default: 2800 },
  delay: { type: Number, default: 0 },
  decimals: { type: Number, default: 0 },
});

function format(n) {
  const value = props.decimals ? n.toFixed(props.decimals) : String(Math.round(n));
  return `${props.prefix}${value}${props.suffix}`;
}

const shown = ref(format(0));
let frame = 0;
let startTimer = 0;

onMounted(() => {
  startTimer = window.setTimeout(() => {
    const start = performance.now();
    const tick = (now) => {
      const t = Math.min((now - start) / props.duration, 1);
      const eased = 1 - (1 - t) ** 2;
      shown.value = format(props.value * eased);
      if (t < 1) frame = requestAnimationFrame(tick);
      else shown.value = `${props.prefix}${Math.round(props.value)}${props.suffix}`;
    };
    frame = requestAnimationFrame(tick);
  }, props.delay);
});

onUnmounted(() => {
  window.clearTimeout(startTimer);
  cancelAnimationFrame(frame);
});
</script>
