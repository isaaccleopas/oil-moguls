<template>
  <span class="inline-flex items-center gap-1.5" :class="className">
    <span
      class="text-[0.95rem] font-bold tracking-tight leading-none sm:text-base"
      :class="variant === 'light' ? 'text-offwhite' : 'text-forest'"
    >
      OIL
    </span>
    <svg class="h-3.5 w-2.5 shrink-0 sm:h-4 sm:w-3" viewBox="0 0 24 32" fill="none" aria-hidden="true">
      <path d="M12 1.2 22.8 16 12 30.8 1.2 16 12 1.2Z" fill="#8FCDA5" />
      <path d="M12 1.2 12 30.8 1.2 16 12 1.2Z" fill="#0E3020" fill-opacity="0.22" />
      <path d="M12 1.2 22.8 16 12 16 12 1.2Z" fill="#F2F6F1" fill-opacity="0.28" />
    </svg>
    <span
      class="text-[0.95rem] font-light tracking-[0.18em] leading-none sm:text-base"
      :class="variant === 'light' ? 'text-offwhite' : 'text-forest'"
    >
      MOGULS
    </span>
  </span>
</template>

<script setup>
defineProps({
  variant: { type: String, default: "forest" },
  className: { type: String, default: "" },
});
</script>
