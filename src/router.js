import { createRouter, createWebHistory } from "vue-router";
import HomePage from "./pages/HomePage.vue";
import AcademyPage from "./pages/AcademyPage.vue";
import ApexBeePage from "./pages/ApexBeePage.vue";
import CommunityPage from "./pages/CommunityPage.vue";
import OpportunitiesPage from "./pages/OpportunitiesPage.vue";
import ConferencePage from "./pages/ConferencePage.vue";
import AboutPage from "./pages/AboutPage.vue";
import AudiencesPage from "./pages/AudiencesPage.vue";
import JoinPage from "./pages/JoinPage.vue";

const router = createRouter({
  history: createWebHistory(),
  scrollBehavior() {
    return { top: 0 };
  },
  routes: [
    { path: "/", name: "home", component: HomePage, meta: { title: "Home" } },
    { path: "/academy", name: "academy", component: AcademyPage, meta: { title: "Academy" } },
    { path: "/apexbee", name: "apexbee", component: ApexBeePage, meta: { title: "ApexBee" } },
    { path: "/community", name: "community", component: CommunityPage, meta: { title: "Community" } },
    { path: "/opportunities", name: "opportunities", component: OpportunitiesPage, meta: { title: "Opportunities" } },
    { path: "/conference", name: "conference", component: ConferencePage, meta: { title: "Conference" } },
    { path: "/about", name: "about", component: AboutPage, meta: { title: "About" } },
    { path: "/audiences", name: "audiences", component: AudiencesPage, meta: { title: "Who we serve" } },
    { path: "/partners", redirect: "/audiences" },
    { path: "/join", name: "join", component: JoinPage, meta: { title: "Join" } },
    { path: "/:pathMatch(.*)*", redirect: "/" },
  ],
});

router.afterEach((to) => {
  const title = to.meta.title ? `${to.meta.title} · Oil Moguls` : "Oil Moguls";
  document.title = title;
});

export default router;
