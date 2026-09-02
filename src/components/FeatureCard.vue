<template>
  <component
    :is="tag"
    class="om-card om-media-card"
    :class="{ 'is-linked': Boolean(to || href) }"
    :to="to || undefined"
    :href="href || undefined"
    :target="href ? '_blank' : undefined"
    :rel="href ? 'noopener noreferrer' : undefined"
  >
    <div class="om-media-visual">
      <img class="om-media-img" :src="image" :alt="alt || title" width="720" height="540" loading="lazy" decoding="async" />
      <span class="om-media-shade" aria-hidden="true" />
      <span v-if="to || href" class="om-media-plus" aria-hidden="true">+</span>
    </div>
    <div class="om-media-copy">
      <p class="om-media-kicker">{{ mark }}</p>
      <h3 class="om-media-title">{{ title }}</h3>
      <p class="om-media-body"><slot /></p>
      <span v-if="to || href" class="om-media-cta" aria-hidden="true"></span>
    </div>
  </component>
</template>

<script setup>
import { computed } from "vue";
import { RouterLink } from "vue-router";

const props = defineProps({
  title: { type: String, required: true },
  mark: { type: String, default: "◇" },
  image: { type: String, required: true },
  alt: { type: String, default: "" },
  to: { type: String, default: "" },
  href: { type: String, default: "" },
});

const tag = computed(() => {
  if (props.to) return RouterLink;
  if (props.href) return "a";
  return "article";
});
</script>
