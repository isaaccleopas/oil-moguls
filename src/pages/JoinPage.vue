<template>
  <PageHero kicker="Join" title="Request access to the community.">
    Tell us which of the thirteen audiences you belong to. We will follow up with Academy, ApexBee, Conference, or the right room, not a company sales pitch.
  </PageHero>
  <section class="py-16 sm:py-24">
    <div class="om-container grid gap-12 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.1fr)]">
      <div>
        <h2 class="om-display text-2xl sm:text-3xl">Members of a learning community. That is the point.</h2>
        <p class="om-body mt-4">
          Oil Moguls is not an oil and gas company. You join as a student, a professional, a trainer, a service company, an investor, or a regulator, as a member of the same community.
        </p>
        <ul class="mt-8 space-y-4 text-sm text-night">
          <li class="flex gap-3"><span class="text-sage">✓</span> Students, graduates, engineers, geoscientists, operators</li>
          <li class="flex gap-3"><span class="text-sage">✓</span> HSE, procurement, executives, consultants</li>
          <li class="flex gap-3"><span class="text-sage">✓</span> Service companies, investors, industry trainers, regulators</li>
        </ul>
      </div>
      <div class="om-card p-6 sm:p-8">
        <div v-if="submitted" class="om-form-success space-y-3">
          <p class="font-mono text-xs tracking-[0.18em] uppercase text-muted">Received</p>
          <h3 class="text-xl font-semibold text-forest">Thank you, {{ form.name }}.</h3>
          <p class="om-body text-sm">We have your request. A member of the team will follow up at {{ form.email }} with the next step for your path.</p>
        </div>
        <form v-else id="join-form" class="space-y-5" @submit.prevent="onSubmit">
          <div>
            <label class="mb-2 block text-sm font-medium text-forest" for="name">Full name</label>
            <input id="name" v-model="form.name" type="text" autocomplete="name" class="om-input" :class="errors.name && 'om-input-error'" />
            <p v-if="errors.name" class="mt-1 text-sm text-danger">{{ errors.name }}</p>
          </div>
          <div>
            <label class="mb-2 block text-sm font-medium text-forest" for="email">Email</label>
            <input id="email" v-model="form.email" type="email" autocomplete="email" class="om-input" :class="errors.email && 'om-input-error'" />
            <p v-if="errors.email" class="mt-1 text-sm text-danger">{{ errors.email }}</p>
          </div>
          <div>
            <label class="mb-2 block text-sm font-medium text-forest" for="role">Your role</label>
            <select id="role" v-model="form.role" class="om-input" :class="errors.role && 'om-input-error'">
              <option value="">Select one</option>
              <option v-for="role in audiences" :key="role.name" :value="role.name">{{ role.name }}</option>
            </select>
            <p v-if="errors.role" class="mt-1 text-sm text-danger">{{ errors.role }}</p>
          </div>
          <div>
            <label class="mb-2 block text-sm font-medium text-forest" for="intent">What you need</label>
            <select id="intent" v-model="form.intent" class="om-input" :class="errors.intent && 'om-input-error'">
              <option value="">Select one</option>
              <option v-for="intent in intents" :key="intent" :value="intent">{{ intent }}</option>
            </select>
            <p v-if="errors.intent" class="mt-1 text-sm text-danger">{{ errors.intent }}</p>
          </div>
          <div>
            <label class="mb-2 block text-sm font-medium text-forest" for="note">Anything we should know</label>
            <textarea id="note" v-model="form.note" rows="4" class="om-input min-h-28"></textarea>
          </div>
          <button type="submit" class="om-btn om-btn-primary w-full">Submit request</button>
        </form>
      </div>
    </div>
  </section>
</template>

<script setup>
import { reactive, ref } from "vue";
import PageHero from "../components/PageHero.vue";
import { audiences, intents } from "../content";

const submitted = ref(false);
const form = reactive({ name: "", email: "", role: "", intent: "", note: "" });
const errors = reactive({ name: "", email: "", role: "", intent: "" });

function onSubmit() {
  errors.name = form.name.trim() ? "" : "Enter your name.";
  errors.email = form.email.includes("@") ? "" : "Enter a valid email.";
  errors.role = form.role ? "" : "Select your role.";
  errors.intent = form.intent ? "" : "Select what you need.";
  if (!errors.name && !errors.email && !errors.role && !errors.intent) {
    submitted.value = true;
  }
}
</script>
