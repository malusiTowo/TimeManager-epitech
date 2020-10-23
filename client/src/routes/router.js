import Vue from 'vue';
import VueRouter from 'vue-router';
import routes from './routes';

Vue.use(VueRouter);

const router = new VueRouter({
  routes,
  linkActiveClass: 'active',
  scrollBehavior: (to, from, savedPosition) => {
    if (savedPosition) {
      return savedPosition;
    }
    if (to.hash) {
      return { selector: to.hash };
    }
    return { x: 0, y: 0 };
  }
});


export const userIdIdentifier = '@TimeManagerUserID';

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (localStorage.getItem(userIdIdentifier) == null) {
      next({
        path: '/login',
        params: { nextUrl: to.fullPath }
      })
    } else next();
    // else {
    //   let user = JSON.parse(localStorage.getItem('user'))
    //   if (to.matched.some(record => record.meta.is_admin)) {
    //     if (user.is_admin == 1) {
    //       next()
    //     }
    //     else {
    //       next({ name: 'dashboard' })
    //     }
    //   } else {
    //     next()
    //   }
    // }
  } else if (to.matched.some(record => record.meta.guest)) {
    if (localStorage.getItem(userIdIdentifier) == null) {
      next()
    }
    else {
      next({ name: 'dashboard' })
    }
  } else {
    next()
  }
})


export default router;
